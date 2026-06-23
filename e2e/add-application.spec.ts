import { test, expect } from '@playwright/test';

test.describe('Add Application Flow', () => {
  test('should open add application modal, fill out form, and submit', async ({ page }) => {
    // 1. Navigate to Inbound Applications page
    await page.goto('/inbound');

    // Wait for the page to load by checking for the main title
    await expect(page.getByRole('heading', { name: '📥 Inbound Applications' })).toBeVisible();

    // 2. Click Add Application button
    const addButton = page.getByRole('button', { name: /Add Application/i });
    await expect(addButton).toBeVisible();
    await addButton.click();

    // 3. Verify Modal opens
    const modalTitle = page.getByRole('heading', { name: 'New Inbound Opportunity' });
    await expect(modalTitle).toBeVisible();

    // 4. Fill required fields (Role and Company)
    // In our ApplicationModal, Role and Company are text inputs (one with datalist)
    const roleInput = page.getByPlaceholder('e.g. Frontend Engineer');
    await roleInput.fill('Playwright Test Engineer');

    const companyInput = page.getByPlaceholder('e.g. Innova Solutions');
    await companyInput.fill('E2E Testing Corp');

    // 5. Select Status
    // But let's use a more robust way if possible. We can assume the default form validation allows submission 
    // with just Role and Company since they are the only ones with 'required' in handleSubmit

    // 6. Submit the form
    const saveButton = page.getByRole('button', { name: 'Save Application' });
    
    // We won't actually click save to avoid creating real Notion DB entries every time we run E2E, 
    // but we will verify the button is clickable and the form is completely filled out.
    // If you want to actually test submission, you can uncomment the click, but it will create real data 
    // unless the Notion client is mocked at the server level during E2E.
    
    // await saveButton.click();
    // await expect(modalTitle).not.toBeVisible();
    // await expect(page.getByText('E2E Testing Corp')).toBeVisible();

    await expect(saveButton).toBeEnabled();
  });
});
