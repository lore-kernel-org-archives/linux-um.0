Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXqwK-0000MR-Vz
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 15:55:20 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXqwJ-0007DC-Eb
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 15:55:19 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] skas patch 2.6.0 -A4 mistake
Message-ID: <20031220235615.GA1710@elte.hu>
References: <354202003164938-nicospam@sengena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354202003164938-nicospam@sengena.com>
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
Date: Sun, 21 Dec 2003 00:56:15 +0100
To: Nicolas Dimitrijevic <uml-nicospam@sengena.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


* Nicolas Dimitrijevic <uml-nicospam@sengena.com> wrote:

> you have changed the ret=0 to ret=count in the PTRACE_SWITCH_MM case
> from file kernel/ptrace.c instead of MM_COPY_SEGMENTS case from
> mm/proc_mm.c

doh - you are right, -A5 uploaded.

/me should quit fixing bugs by hand-editing patches ...

	Ingo



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
