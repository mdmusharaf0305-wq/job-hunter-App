/* eslint-disable @typescript-eslint/no-explicit-any */
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { vi, describe, it, expect } from 'vitest';
import DashboardClient from './DashboardClient';
import { updateApplicationAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';

// Mock next/navigation
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    refresh: vi.fn(),
  }),
}));

// Mock server actions
vi.mock('../../actions/recruiterActions', () => ({
  updateApplicationAction: vi.fn(),
  getDatabaseSchemaOptionsAction: vi.fn(),
}));

// Mock framer-motion to avoid animation issues in tests
vi.mock('framer-motion', async () => {
  const actual = await vi.importActual('framer-motion') as any;
  return {
    ...actual,
    motion: {
      div: ({ children, ...props }: any) => <div {...props}>{children}</div>,
      span: ({ children, ...props }: any) => <span {...props}>{children}</span>,
      button: ({ children, ...props }: any) => <button {...props}>{children}</button>,
    },
  };
});

describe('DashboardClient Integration Tests', () => {
  const mockMetrics = {
    totalApplications: 10,
    activeApplications: 5,
    interviewsCount: 2,
    offersCount: 1,
    rejectionsCount: 2,
    responseRate: 50,
    upcomingInterviews: [],
    weeklyProgress: { current: 0, previous: 0, percentage: 0 },
    allApplications: [
      {
        id: 'app-high',
        role: 'Frontend Dev',
        company: 'High Priority Corp',
        status: '📞 HR Screening', // Standard screening
        priority: 'High',
        type: 'inbound',
      },
      {
        id: 'app-med',
        role: 'Backend Dev',
        company: 'Medium Priority Corp',
        status: '📞 HR Screening',
        priority: 'Medium',
        type: 'inbound',
      },
      {
        id: 'app-outbound',
        role: 'Full Stack',
        company: 'Outbound Corp',
        status: '📨 Resume Shared',
        callStatus: 'Dialed',
        priority: 'High',
        type: 'outbound',
      },
      {
        id: 'app-other',
        role: 'Data Scientist',
        company: 'Other Corp',
        status: '📄 Applied',
        priority: 'High',
        type: 'inbound',
      }
    ]
  } as any;

  it('should correctly filter screening applications based on active tab', async () => {
    (getDatabaseSchemaOptionsAction as any).mockResolvedValue({
      statuses: ['📞 HR Screening', '🤖 AI Round', '📨 Resume Shared', '📄 Applied']
    });
    render(<DashboardClient initialMetrics={mockMetrics} />);

    // Need to wait for schema options to load before rendering is completely stable
    await waitFor(() => {
      expect(screen.getAllByText('High Priority Corp')[0]).toBeInTheDocument();
    });

    // Initially "all" is active, should show 3 screening apps (2 standard + 1 outbound)
    expect(screen.getAllByText('High Priority Corp')[0]).toBeInTheDocument();
    expect(screen.getAllByText('Medium Priority Corp')[0]).toBeInTheDocument();
    expect(screen.getAllByText('Outbound Corp')[0]).toBeInTheDocument();
    // 'app-other' should not be in screening list
    expect(screen.queryByText('Other Corp')).not.toBeInTheDocument();

    // Click "high" tab
    fireEvent.click(screen.getAllByText('high')[0]);
    expect(screen.getAllByText('High Priority Corp')[0]).toBeInTheDocument();
    expect(screen.getAllByText('Outbound Corp')[0]).toBeInTheDocument();
    expect(screen.queryByText('Medium Priority Corp')).not.toBeInTheDocument();

    // Click "medium" tab
    fireEvent.click(screen.getAllByText('medium')[0]);
    expect(screen.getAllByText('Medium Priority Corp')[0]).toBeInTheDocument();
    expect(screen.queryByText('High Priority Corp')).not.toBeInTheDocument();
    expect(screen.queryByText('Outbound Corp')).not.toBeInTheDocument();
  });

  it('should call updateApplicationAction when status is changed', async () => {
    (getDatabaseSchemaOptionsAction as any).mockResolvedValue({
      statuses: ['📞 HR Screening', '🤖 AI Round', '📨 Resume Shared', '📄 Applied']
    });
    (updateApplicationAction as any).mockResolvedValue({ success: true });

    render(<DashboardClient initialMetrics={mockMetrics} />);

    await waitFor(() => {
      // Find the select element for High Priority Corp's status
      const selectBoxes = screen.getAllByRole('combobox');
      expect(selectBoxes.length).toBeGreaterThan(0);
    });

    const selectBoxes = screen.getAllByRole('combobox');
    const firstSelect = selectBoxes[0];

    fireEvent.change(firstSelect, { target: { value: '🤖 AI Round' } });

    await waitFor(() => {
      expect(updateApplicationAction).toHaveBeenCalledWith('app-high', { status: '🤖 AI Round' });
    });
  });
});
