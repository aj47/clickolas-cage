import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import SidePanel from '../sidepanel/SidePanel';

vi.mock('@mocks/chrome', () => ({
  chrome: {
    runtime: {
      onMessage: {
        addListener: vi.fn(),
      },
    },
  },
}));

describe('SidePanel', () => {
  it('renders the Clickolas Cage title', () => {
    render(<SidePanel />);
    const titleElement = screen.getByText('Clickolas Cage');
    expect(titleElement).toBeInTheDocument();
  });
});
