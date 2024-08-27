import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';

const SimpleComponent = () => <div>Hello, World!</div>;

describe('Minimal React Test', () => {
  it('renders a simple React component', () => {
    render(<SimpleComponent />);
    expect(screen.getByText('Hello, World!')).toBeInTheDocument();
  });
});
