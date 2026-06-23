import type { Metadata } from "next";
import { Inter, Fira_Code } from "next/font/google";
import Sidebar from "../components/Sidebar";
import PageTransition from "../components/PageTransition";
import ChatbotBubble from "../components/ChatbotBubble";
import "./globals.css";

const inter = Inter({
  variable: "--font-sans",
  subsets: ["latin"],
});

const firaCode = Fira_Code({
  variable: "--font-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Mushi's Job Hunt",
  description: "A premium job search OS & CRM built for professional developers.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${inter.variable} ${firaCode.variable} h-full antialiased`}
    >
      <body className="min-h-full bg-background text-foreground font-sans antialiased overflow-x-hidden">
        {/* Sleek Gradient Grid overlay */}
        <div className="fixed inset-0 grid-bg pointer-events-none z-0 opacity-80" />
        
        {/* Glow orbs */}
        <div className="fixed top-[-20%] right-[-10%] w-[600px] h-[600px] rounded-full bg-[#5e6ad2]/10 blur-[150px] pointer-events-none z-0" />
        <div className="fixed bottom-[-20%] left-[10%] w-[500px] h-[500px] rounded-full bg-[#06b6d4]/5 blur-[120px] pointer-events-none z-0" />

        <div className="relative z-10 flex min-h-screen">
          {/* Sidebar */}
          <Sidebar />
          
          {/* Main Content Area */}
          <main className="flex-1 min-w-0 w-full max-w-full lg:ml-64 min-h-[100dvh] flex flex-col p-4 md:p-8 lg:p-10 pt-[calc(5rem+env(safe-area-inset-top,0px))] lg:pt-10 transition-all duration-300">
            <PageTransition>
              {children}
            </PageTransition>
          </main>

          {/* Floating Chatbot Bubble */}
          <ChatbotBubble />
        </div>
      </body>
    </html>
  );
}
