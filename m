Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AcjjG-0004W5-Tg for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jan 2004 03:14:02 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AcjjG-0000rO-E0 for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jan 2004 03:14:02 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] NPTL + UML?
In-Reply-To: <3FF5D31A.8050503@timesys.com>
Message-ID: <Pine.GSO.4.58.0401031108450.22595@altair.dur.ac.uk>
References: <3FF5D31A.8050503@timesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 3 Jan 2004 11:13:44 +0000 (GMT)
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Fri, 2 Jan 2004, La Monte H.P. Yarroll wrote:

> Is anybody out there working on getting thread-local storage (i.e. NPTL)
> working with UML?  I see that set_thread_area(2) and get_thread_area(2)
> are both sys_ni_syscall in arch/um/kernel/sys_call_table.c.
>
> The lack of NPTL support causes me a lot of grief...

I did start to look at it, but ran into trouble with (possibly unrelated)
bugs, I didn't succeed in debugging. In principle it should be easy to do
by passing on the system call to the parent kernel (perhaps via ptrace).

	Michael Young


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
