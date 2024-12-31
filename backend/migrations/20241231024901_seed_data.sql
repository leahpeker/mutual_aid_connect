-- Add migration script here
-- Insert test users
INSERT INTO users (id, username, email, password_hash) VALUES
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'john_doe', 'john@example.com', 'dummy_hash_1'),
    ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'jane_smith', 'jane@example.com', 'dummy_hash_2'),
    ('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'bob_wilson', 'bob@example.com', 'dummy_hash_3');

-- Insert test campaigns
INSERT INTO campaigns (
    id, 
    title, 
    description, 
    creator_id, 
    target_amount, 
    current_amount, 
    location_lat, 
    location_lng, 
    ends_at
) VALUES
    (
        'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14',
        'Community Garden Project',
        'Help us build a community garden in downtown Atlanta',
        'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
        5000.00,
        2500.00,
        33.7490,
        -84.3880,
        NOW() + INTERVAL '30 days'
    ),
    (
        'e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15',
        'Food Bank Drive',
        'Supporting local families in need with essential groceries',
        'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12',
        3000.00,
        1200.00,
        33.7590,
        -84.3920,
        NOW() + INTERVAL '45 days'
    ),
    (
        'f0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16',
        'Emergency Relief Fund',
        'Providing immediate assistance to those affected by recent storms',
        'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13',
        10000.00,
        7500.00,
        33.7690,
        -84.4000,
        NOW() + INTERVAL '60 days'
    );