import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import SidePanel from '../src/sidepanel/SidePanel'; // Adjust this path if necessary

describe('SidePanel', () => {
  it('renders the Clickolas Cage title', () => {
    render(<SidePanel />);
    const titleElement = screen.getByText('Clickolas Cage');
    expect(titleElement).toBeInTheDocument();
  });

  // Add more unit tests for SidePanel component
});
