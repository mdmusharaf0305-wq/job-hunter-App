/* eslint-disable @typescript-eslint/no-explicit-any */
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { vi, describe, it, expect } from 'vitest';
import ApplicationModal from './ApplicationModal';

// Removed lucide-react mock to let JSDOM render actual icons

describe('ApplicationModal', () => {
  const defaultProps = {
    isOpen: true,
    onClose: vi.fn(),
    onSave: vi.fn(),
    application: {
      id: 'app-1',
      role: 'Frontend Dev',
      company: 'Acme Corp',
      client: 'Acme',
      status: '📄 Applied' as any,
      type: 'inbound' as any,
      priority: 'High' as any,
      lastUpdated: '2026-06-12',
    },
    dbOptions: {
      roles: ['Frontend Dev', 'Backend Dev'],
      salaries: ['10LPA', '20LPA'],
      roundPlans: ['HR', 'Tech'],
      totalRounds: ['1 Round', '2 Rounds'],
      employmentTypes: ['Full-Time'],
      companyTypes: ['Product Based'],
      companySizes: ['101-500', '500-10000', '1000-2000', '2000-3000', '3000+'],
      locations: ['Remote', 'Onsite'],
      clients: ['Acme'],
      statuses: ['📄 Applied', '📞 HR Screening'],
      eventCategories: [],
      virtualModes: [],
      interviewModes: [],
      callStatuses: [],
      followupChannels: ['Email', 'LinkedIn']
    }
  };

  it('should render the modal when isOpen is true', () => {
    render(<ApplicationModal {...defaultProps} />);
    expect(screen.getByText('Edit Application')).toBeInTheDocument();
  });

  it('should not render anything when isOpen is false', () => {
    const { container } = render(<ApplicationModal {...defaultProps} isOpen={false} />);
    expect(container).toBeEmptyDOMElement();
  });

  it('should call onClose when cancel button is clicked', () => {
    render(<ApplicationModal {...defaultProps} />);
    const cancelButton = screen.getByText('Cancel');
    fireEvent.click(cancelButton);
    expect(defaultProps.onClose).toHaveBeenCalledTimes(1);
  });

  it('should call onClose when X icon is clicked', () => {
    render(<ApplicationModal {...defaultProps} />);
    // Select the button that contains the X icon
    const closeButtons = screen.getAllByRole('button');
    // The first button in the header is the close button
    fireEvent.click(closeButtons[0]);
    expect(defaultProps.onClose).toHaveBeenCalled();
  });

  it('should render form fields based on application data', () => {
    render(<ApplicationModal {...defaultProps} />);
    expect(screen.getByDisplayValue('Frontend Dev')).toBeInTheDocument();
    expect(screen.getByDisplayValue('Acme Corp')).toBeInTheDocument();
    expect(screen.getByDisplayValue('📄 Applied')).toBeInTheDocument();
  });

  it('should allow user to modify a text input and select a dropdown', async () => {
    render(<ApplicationModal {...defaultProps} />);
    
    // Modify Role (Text input mapped with datalist)
    const roleInput = screen.getByDisplayValue('Frontend Dev');
    fireEvent.change(roleInput, { target: { value: 'Backend Dev' } });
    expect(screen.getByDisplayValue('Backend Dev')).toBeInTheDocument();

    // Modify Status (Select)
    const statusSelect = screen.getByDisplayValue('📄 Applied');
    fireEvent.change(statusSelect, { target: { value: '📞 HR Screening' } });
    expect(screen.getByDisplayValue('📞 HR Screening')).toBeInTheDocument();
  });

  it('should submit the modified data when clicking Save', async () => {
    const onSaveMock = vi.fn().mockResolvedValue(undefined);
    render(<ApplicationModal {...defaultProps} onSave={onSaveMock} />);
    
    // Modify priority to Low
    const prioritySelect = screen.getByDisplayValue('High');
    fireEvent.change(prioritySelect, { target: { value: 'Low' } });

    // Submit form
    const saveButton = screen.getByText('Save Changes');
    fireEvent.click(saveButton);

    await waitFor(() => {
      expect(onSaveMock).toHaveBeenCalled();
      const submittedData = onSaveMock.mock.calls[0][0];
      expect(submittedData.priority).toBe('Low');
    });
  });
});
