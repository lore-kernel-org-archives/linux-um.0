Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnFVR-0006Bx-Ra for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 04:15:45 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CnFVQ-0002gk-3f for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 04:15:45 -0800
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<20050103133412.GA25262@bytesex>
	<200501031531.19246.Armin.Warda@gmx.de>
In-Reply-To: <200501031531.19246.Armin.Warda@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501081315.34841.blaisorblade_personal@yahoo.it>
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
Date: Sat, 8 Jan 2005 13:15:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Armin.Warda@gmx.de
Cc: Gerd Knorr <kraxel@bytesex.org>, "Christopher S. Aker" <caker@theshore.net>

On Monday 03 January 2005 15:31, Armin M. Warda wrote:
>   Hi Gerd,

> On Monday 03 January 2005 14:34, you wrote:
> > host or uml kernel fix?  URL?  Havn't tracked stuff at all over
> > xmas holidays ...
>
> Must be a host-Kernel fix, not a uml-kernel fix, because um-kernel
> 2.6.9-bb4 running on host-kernels
[...]
Yes, this is definitely a host bug, which was reported to the appropriate 
people and fixed...

> I scanned the changelog for 2.6.10 but until now failed to identify
> the patch:
>
>   http://www.de.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.10

I had read the Changelog from -rc3 to final (after hearing from Christopher 
Aker that in -bk it had been fixed), and I seemed had a quick shoot about 
this... it was a fix from Roland McGrath about something strange, which made 
me guess it was the fix...

Roland McGrath:

  o fix bogus ECHILD return from wait* with zombie group leader

I'm not sure this is the fix, but it is possible indeed, given that the 
problem UML triggered was, IIRC, that when it exited, there wasn't a proper 
cleanup of the status, and the process became invisible but still kept a 
reference to the file in /tmp, preventing it from being deleted...

The changelog does not mention our particular bug it but there is a good 
reason for not mentioning it, and it's related to TASK_TRACED which is *the* 
problem in 2.6.9 with UML.

I think you can search for it on linux.bkbits.net... I'll do that when I have 
time...

However, I've received (after 2.6.10) the answer from Roland McGrath (ptrace 
coder / maintainer) about this problem, and he sent two more patches for 
this, which I'll bundle in next SKAS as a temp. solution and forward to 
you... I'll check if it is a complete solution.

> Can somebody else on the list help me to identify the patch for
> this "problem with /tmp filling irreversibly and being unable to
> unmount /tmp" bugfix? Thanks!

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
