Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpFGn-0000NI-Hf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:24:53 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpFGi-0007Qy-RH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 16:24:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Fix stack corruption
References: <200501121856.j0CIuMiZ003766@ccure.user-mode-linux.org>
	<002001c4f9c7$de282ec0$0201a8c0@hawk>
In-Reply-To: <002001c4f9c7$de282ec0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501140127.09333.blaisorblade@yahoo.it>
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
Date: Fri, 14 Jan 2005 01:27:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>

On Friday 14 January 2005 00:30, Christopher S. Aker wrote:
> > The fix is obvious:
> >
> > Index: 2.6.10/arch/um/kernel/skas/process.c
> > ===================================================================
> > --- 2.6.10.orig/arch/um/kernel/skas/process.c 2005-01-12
> > 11:17:22.000000000 -0500 +++ 2.6.10/arch/um/kernel/skas/process.c
> > 2005-01-12 11:18:03.000000000 -0500 @@ -323,9 +323,10 @@
> >   block_signals();
> >   if(sigsetjmp(fork_buf, 1) == 0)
> >   new_thread_proc(stack, handler);
> > - set_signals(flags);
> >
> >   remove_sigstack();
> > +
> > + set_signals(flags);
> >  }
> >
> >  void thread_wait(void *sw, void *fb)
>
> Just a follow up on this for the sake of a paper trail...  This doesn't fix
> the test-case below:
>
> http://www.theshore.net/~caker/uml/crashkit-no-console-output/
>
> readme.txt:
> ----
> All you need is an UML guest assigned an IP on your network, iptables, and
> the two files below in the same directory.  Run the script, while
> ping-flooding the UML's IP address from the host, or another machine on
> your network.
>
> This script works best with a 2.6 based UML.  I can recreate the crash
> easily using 2.6.9-linode9 (based on -bb4), also available on this website.
> ----
>
> I believe we've figured out that this is skas3 specific.  Once you start
> ping-flooding the UML, it crashes within a second.
I wasn't able to riproduce it... I ran two instances of the above loop + a 
ping flood from the host, but it didn't crash UML, even after letting it that 
way for some minutes.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
