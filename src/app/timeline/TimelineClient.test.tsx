/* eslint-disable @typescript-eslint/no-explicit-any */
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { vi, describe, it, expect } from 'vitest';
import TimelineClient from './TimelineClient';
import { createTimelineEventAction } from '../../actions/timelineActions';

// Mock next/navigation
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    refresh: vi.fn(),
  }),
}));

// Mock server actions
vi.mock('../../actions/timelineActions', () => ({
  createTimelineEventAction: vi.fn(),
}));

describe('TimelineClient', () => {
  const mockApplications = [
    {
      id: 'app-1',
      role: 'Frontend Dev',
      company: 'Acme Corp',
      status: '📄 Applied',
    }
  ] as any;

  const mockEvents = [
    {
      id: 'event-1',
      title: 'Applied',
      date: '2026-06-01',
      category: 'Application',
      opportunity: 'app-1',
      notes: ''
    }
  ] as any;

  const defaultProps = {
    initialEvents: mockEvents,
    applications: mockApplications,
    dbOptions: {} as any,
    etOptions: ['Application', 'Interview'],
    categoryOptions: ['Round 1', 'Round 2'],
    virtualModeOptions: ['Google Meet', 'Zoom'],
  };

  it('should render the timeline grouping events by company', () => {
    render(<TimelineClient {...defaultProps} />);
    expect(screen.getByText('Acme Corp')).toBeInTheDocument();
    
    // Click to expand events
    fireEvent.click(screen.getByText('Acme Corp'));
    expect(screen.getByText('Applied')).toBeInTheDocument();
  });

  it('should open the modal when Add is clicked', () => {
    render(<TimelineClient {...defaultProps} />);
    const addButton = screen.getByRole('button', { name: /Add Event/i });
    fireEvent.click(addButton);
    expect(screen.getByRole('heading', { name: 'Add Event' })).toBeInTheDocument();
  });

  it('should call createTimelineEventAction and close modal upon save', async () => {
    (createTimelineEventAction as any).mockResolvedValue({ success: true, id: 'new-event-1' });

    render(<TimelineClient {...defaultProps} />);
    
    // Open modal
    fireEvent.click(screen.getByRole('button', { name: /Add Event/i }));
    
    // Fill category
    const categorySelect = screen.getAllByDisplayValue('Select...')[0];
    fireEvent.change(categorySelect, { target: { value: 'Round 1' } });

    // Fill title
    const titleSelect = screen.getByDisplayValue('Select ET...');
    fireEvent.change(titleSelect, { target: { value: 'Application' } });

    // Submit form
    const submitButton = screen.getByRole('button', { name: /Save/i });
    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(createTimelineEventAction).toHaveBeenCalled();
      // Wait for modal to close
      expect(screen.queryByRole('heading', { name: 'Add Event' })).not.toBeInTheDocument();
    });
  });
});
