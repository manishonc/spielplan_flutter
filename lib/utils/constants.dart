const bool useLocalEnvironment = true;

const String localSupabaseUrl = 'http://127.0.0.1:54321';
const String localSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

const String productionSupabaseUrl = 'https://uxxmskbviznjcxspqmox.supabase.co';
const String productionSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV4eG1za2J2aXpuamN4c3BxbW94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE4Njc5MjMsImV4cCI6MjAxNzQ0MzkyM30.sNov6geDfcCMz-A-S1yS7wBRHxO4wjC7-fyyJ8sPuHI';

const String supabaseUrl =
    useLocalEnvironment ? localSupabaseUrl : productionSupabaseUrl;
const String supabaseAnonKey =
    useLocalEnvironment ? localSupabaseAnonKey : productionSupabaseAnonKey;
