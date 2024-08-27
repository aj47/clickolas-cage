import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import SidePanel from '../src/sidepanel/SidePanel';

describe('Simplified SidePanel Test', () => {
  it('renders without crashing', () => {
    render(<SidePanel />);
    // Just check if any part of the component renders
    expect(screen.getByText(/Clickolas Cage/i)).toBeInTheDocument();
  });
});
