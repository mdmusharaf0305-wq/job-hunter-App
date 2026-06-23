'use server';

import { revalidatePath } from 'next/cache';

import { notion } from '../lib/notion/client';
import { TimelineEvent } from '../types';

export async function getTimelineSchemaAction(): Promise<{ etOptions: string[], categoryOptions: string[], virtualModeOptions: string[] }> {
  const TIMELINE_DB_ID = (process.env.APPLICATION_TIMELINE_DB_ID || '').trim();
  if (!TIMELINE_DB_ID || !notion) return { etOptions: [], categoryOptions: [], virtualModeOptions: [] };
  try {
    const data = await notion.request<any>({
      path: `databases/${TIMELINE_DB_ID.replace(/-/g, '')}`,
      method: 'get'
    });
    const etProp = data.properties['📝 ET'];
    const etOptions = etProp?.select?.options?.map((o: { name: string }) => o.name) || [];
    
    // Find the category property (often '🎯 Event Category')
    const categoryPropKey = Object.keys(data.properties).find(k => k.includes('Event Category'));
    const categoryProp = categoryPropKey ? data.properties[categoryPropKey] : null;
    const categoryOptions = categoryProp?.select?.options?.map((o: { name: string }) => o.name) || [];
    
    // Find Virtual Mode property
    const virtualModeProp = data.properties['Interview Mode'];
    const virtualModeOptions = virtualModeProp?.status?.options?.map((o: { name: string }) => o.name) || virtualModeProp?.select?.options?.map((o: { name: string }) => o.name) || [];
    
    return { etOptions, categoryOptions, virtualModeOptions };
  } catch (e) {
    console.error('Error fetching timeline schema', e);
    return { etOptions: [], categoryOptions: [], virtualModeOptions: [] };
  }
}

// The timeline db id
export async function getTimelineEventsAction(): Promise<TimelineEvent[]> {
  const TIMELINE_DB_ID = (process.env.APPLICATION_TIMELINE_DB_ID || '').trim();
  if (!TIMELINE_DB_ID || !notion) return [];
  
  try {
    const responseData = await notion.request<any>({
      path: `databases/${TIMELINE_DB_ID.replace(/-/g, '')}/query`,
      method: 'post',
      body: {
        sorts: [{ property: '📅 Event Date', direction: 'descending' }]
      }
    });
    
    return responseData.results.map((page: {
      id: string;
      properties: Record<string, {
        relation?: Array<{ id: string }>;
        select?: { name: string } | null;
        date?: { start: string | null } | null;
        title?: Array<{ plain_text: string }>;
        status?: { name: string } | null;
        rich_text?: Array<{ plain_text: string }>;
      }>;
    }) => {
      const props = page.properties;
      return {
        id: page.id,
        opportunity: props['Oppurtunity']?.relation?.[0]?.id || '',
        category: props['🎯 Event Category']?.select?.name || '',
        date: props['📅 Event Date']?.date?.start || '',
        title: props['📝 ET']?.select?.name || props['📝 Event Title 1']?.title?.[0]?.plain_text || 'Untitled Event',
        virtualMode: props['Interview Mode']?.status?.name || '',
        notes: props['📋 Notes']?.rich_text?.[0]?.plain_text || ''
      };
    });
  } catch (error) {
    console.error('Error fetching timeline events:', error);
    return [];
  }
}

export async function createTimelineEventAction(data: Partial<TimelineEvent>) {
  const TIMELINE_DB_ID = (process.env.APPLICATION_TIMELINE_DB_ID || '').trim();
  if (!TIMELINE_DB_ID) throw new Error('Timeline DB not configured');
  
  try {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const properties: Record<string, any> = {
      '📝 Event Title 1': {
        title: [
          {
            text: {
              content: data.title || 'Untitled Event'
            }
          }
        ]
      },
      '🎯 Event Category': {
        select: {
          name: data.category || '🎤 Interview'
        }
      },
      '📅 Event Date': {
        date: {
          start: data.date || new Date().toISOString().split('T')[0]
        }
      }
    };

    if (data.title) {
      properties['📝 ET'] = { select: { name: data.title } };
    }

    if (data.opportunity) {
      properties['Oppurtunity'] = { relation: [{ id: data.opportunity }] };
    }
    if (data.virtualMode) {
      properties['Interview Mode'] = { status: { name: data.virtualMode } };
    }
    if (data.notes) {
      properties['📋 Notes'] = { rich_text: [{ text: { content: data.notes } }] };
    }

    const response = await notion!.pages.create({
      parent: { database_id: TIMELINE_DB_ID },
      properties
    });

    revalidatePath('/', 'layout');

    return { success: true, id: response.id };
  } catch (error) {
    const err = error as { message?: string };
    console.error('Error creating timeline event:', error);
    return { success: false, error: err.message || 'Unknown error' };
  }
}

export async function updateTimelineEventAction(id: string, data: Partial<TimelineEvent>) {
  try {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const properties: Record<string, any> = {};
    
    if (data.date !== undefined) {
      properties['📅 Event Date'] = {
        date: {
          start: data.date || null
        }
      };
    }
    
    if (data.notes !== undefined) {
      properties['📋 Notes'] = {
        rich_text: [{ text: { content: data.notes || '' } }]
      };
    }

    if (data.title !== undefined) {
      properties['📝 Event Title 1'] = {
        title: [
          {
            text: {
              content: data.title || 'Untitled Event'
            }
          }
        ]
      };
      properties['📝 ET'] = { select: { name: data.title || 'Untitled Event' } };
    }

    if (data.category !== undefined) {
      properties['🎯 Event Category'] = {
        select: data.category ? { name: data.category } : null
      };
    }

    if (data.virtualMode !== undefined) {
      properties['Interview Mode'] = data.virtualMode
        ? { status: { name: data.virtualMode } }
        : null;
    }

    await notion!.pages.update({
      page_id: id,
      properties
    });

    revalidatePath('/', 'layout');

    return { success: true };
  } catch (error) {
    const err = error as { message?: string };
    console.error('Error updating timeline event:', error);
    return { success: false, error: err.message || 'Unknown error' };
  }
}

