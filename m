Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaXui-0002zC-2B
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 28 Dec 2003 02:12:48 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AaXuh-0001yA-Od
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 28 Dec 2003 02:12:47 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031228101240.GN17472@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net> <20031228093317.GK17472@alcor.net> <20031228095115.GL17472@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228095115.GL17472@alcor.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 Dec 2003 02:12:40 -0800
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

On Sun, Dec 28, 2003 at 01:51:15AM -0800, Matt Zimmerman wrote:

> This is making less and less sense.  handle_trap has this code:
> 
> 	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
> 	UPT_SYSCALL_NR(regs) = syscall_nr;
> 	if(syscall_nr < 1){
> 		relay_signal(SIGTRAP, regs);
> 		return;
> 	}
> 
> As I understand it, PT_SYSCALL_NR refers to ORIG_EAX, and UPT_SYSCALL_NR
> refers to skas.syscall.  i.e., syscall=0 can't happen.  So either things are
> not as they seem, or something is happening to regs between here and
> execute_syscall_skas.

[a few hundred printf's later]

So, the sequence of events in handle_trap is this:

1. UPT_SYSCALL_NR(regs) == 78

2. ptrace(PTRACE_POKEUSER,...)

3. UPT_SYSCALL_NR(regs) == 78 (still OK)

4. ptrace(PTRACE_SYSCALL,...)

5. UPT_SYSCALL_NR(regs) == 78 (still OK)

6. waitpid(pid,...)

7. UPT_SYSCALL_NR(regs) == 0 (boom)

I have no idea why.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
