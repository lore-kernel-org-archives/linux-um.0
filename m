Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Coovr-0006Ba-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 12:17:31 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Coovm-0000u5-S9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 12:17:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] process creep on host FC2, UML 2.4.27
References: <20050112190802.GE13602@crow.cs.ucsb.edu>
In-Reply-To: <20050112190802.GE13602@crow.cs.ucsb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501122119.38790.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 21:19:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Daniel Nurmi <nurmi@pompone.cs.ucsb.edu>

On Wednesday 12 January 2005 20:08, Daniel Nurmi wrote:
> Greetings,
>
> We're currently running a course using UML to do some kernel
> developement but have run into a confusing snag.  Our host machines
> are pretty much stock Fedora (FC2) boxes running kernel
> 2.6.9-1.6_FC2smp and our UML kernels are 2.4.27 (clean kernel source,
> 2.4.27uml patch).
>
> When we start a process under UML, a corresponding kernel thread is
> started on the host (which is normal and to be expected) but when the
> process under UML exits the corresponding host thread does not exit
> (which is not expected).  After a short time, of course, the host is
> swamped with thousands of processes, all of which exit cleanly when
> the UML is halted or killed.
>
> I cannot replicate this behaviour on a clean 2.6.7, 2.6.7 SMP, or
> 2.6.8 SMP kernel (on other systems) and our admin tells us that this
> problem did not exist on these same machines running FC1.
>
> If anyone has any input about a cause or fix to this issue, I would be
> greatly appreciative!

This is a FAQ about 2.6.9. There are some patches out there (search for 
fix-kill by C. Aker for the 2.4 backport of the fix).

Bye
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
