import { describe, it, expect } from 'vitest';
import { mapRawStatusToBaseStage, mapNotionStatusToFormulaStatus, mapPageToApplication } from './client';

describe('client mappings', () => {
  describe('mapRawStatusToBaseStage', () => {
    it('should map sourcing related statuses correctly', () => {
      expect(mapRawStatusToBaseStage('applied')).toBe('sourcing');
      expect(mapRawStatusToBaseStage('resume shared')).toBe('sourcing');
      expect(mapRawStatusToBaseStage('not started')).toBe('not_started');
    });

    it('should map screening related statuses correctly', () => {
      expect(mapRawStatusToBaseStage('hr screening')).toBe('screening');
      expect(mapRawStatusToBaseStage('shortlisted')).toBe('screening');
    });

    it('should map interview related statuses correctly', () => {
      expect(mapRawStatusToBaseStage('ai round')).toBe('interview');
      expect(mapRawStatusToBaseStage('technical round 1')).toBe('interview');
    });

    it('should map offer related statuses correctly', () => {
      expect(mapRawStatusToBaseStage('offer received')).toBe('offered');
    });

    it('should default unknown status to sourcing', () => {
      expect(mapRawStatusToBaseStage('random status')).toBe('sourcing');
    });
  });

  describe('mapNotionStatusToFormulaStatus', () => {
    it('should handle undefined and empty string correctly', () => {
      expect(mapNotionStatusToFormulaStatus(undefined)).toBe('⚪ Not Started');
      expect(mapNotionStatusToFormulaStatus('')).toBe('⚪ Not Started');
      expect(mapNotionStatusToFormulaStatus('   ')).toBe('⚪ Not Started');
    });

    it('should map sourcing statuses correctly', () => {
      expect(mapNotionStatusToFormulaStatus('📄 Applied')).toBe('📥 Sourcing');
      expect(mapNotionStatusToFormulaStatus('📨 Resume Shared')).toBe('📥 Sourcing');
      expect(mapNotionStatusToFormulaStatus('sourcing')).toBe('📥 Sourcing');
    });

    it('should map screening statuses correctly', () => {
      expect(mapNotionStatusToFormulaStatus('📞 HR Screening')).toBe('☎️ Screening');
      expect(mapNotionStatusToFormulaStatus('🔍 Shortlisted')).toBe('☎️ Screening');
    });

    it('should map interview pipeline statuses correctly', () => {
      expect(mapNotionStatusToFormulaStatus('🤖 AI Round')).toBe('🎯 Interview Pipeline');
      expect(mapNotionStatusToFormulaStatus('🧠 Technical Round 1')).toBe('🎯 Interview Pipeline');
      expect(mapNotionStatusToFormulaStatus('💬 Final HR')).toBe('🎯 Interview Pipeline');
    });

    it('should map terminal statuses correctly', () => {
      expect(mapNotionStatusToFormulaStatus('🎉 Offer Received')).toBe('💰 Offer Stage');
      expect(mapNotionStatusToFormulaStatus('❌ Rejected')).toBe('💔 Better Luck Next Time');
      expect(mapNotionStatusToFormulaStatus('🚶 Drop')).toBe('💔 Better Luck Next Time');
    });

    it('should return default fallback for unknown status', () => {
      expect(mapNotionStatusToFormulaStatus('Unknown Custom Status')).toBe('❌ Closed');
    });
  });

  describe('mapPageToApplication', () => {
    it('should handle completely empty properties safely', () => {
      const mockPage = { id: 'mock-id-123', properties: {} };
      const app = mapPageToApplication(mockPage);
      
      expect(app.id).toBe('mock-id-123');
      expect(app.company).toBe('Unknown Company');
      expect(app.role).toBe('Unknown Role');
      expect(app.client).toBe('Direct');
      expect(app.status).toBe('⚪ Not Started');
      expect(app.type).toBe('outbound');
      expect(app.resumeSent).toBe(false);
    });

    it('should correctly infer inbound type when recruiter type contains inbound', () => {
      const mockPage = {
        id: 'mock-id',
        properties: {
          'Type': { type: 'select', select: { name: 'Inbound Sourcing' } }
        }
      };
      const app = mapPageToApplication(mockPage);
      expect(app.type).toBe('inbound');
    });

    it('should fall back correctly for nested rich text and title properties', () => {
      const mockPage = {
        id: 'mock-id',
        properties: {
          'Company Name': { type: 'title', title: [{ plain_text: 'Google' }] },
          'Role': { type: 'rich_text', rich_text: [{ plain_text: 'Software Engineer' }] },
          'Client': { type: 'select', select: { name: 'Alphabet' } }
        }
      };
      const app = mapPageToApplication(mockPage);
      
      expect(app.company).toBe('Google');
      expect(app.role).toBe('Software Engineer');
      expect(app.client).toBe('Alphabet');
    });
  });
});
