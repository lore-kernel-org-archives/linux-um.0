Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <stano@meduna.org>) id 1LrGRi-0006A6-C9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 18:54:54 +0000
Received: from www.meduna.org ([92.240.244.38] helo=meduna.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LrGRh-0005YV-98
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 18:54:54 +0000
Message-ID: <49DB9B13.80203@meduna.org>
Date: Tue, 07 Apr 2009 20:27:31 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <49DB91C6.7030005@gmx.de>
In-Reply-To: <49DB91C6.7030005@gmx.de>
Subject: Re: [uml-devel] Multi-threaded applications and floating point
	registers
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ingo van Lil <inguin@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Ingo van Lil wrote:

> I'm experiencing some weird problems with a multi-threaded application 
> I'm working on: A function which uses nothing but a single input value, 
> a few constants and a couple of floating point operations returns wrong 
> results from time to time. The application uses multiple threads, and 
> we're suspecting that the FPU state isn't properly saved and restored 
> when switching between threads within a process.

I had a similar problem between processes a few months ago,
I also posted an example, unfortunately with no resolution
nor further inquiries from the developers. I suspect the skas3
patch does not get much attention now...

Try to run the guest with mode=skas0 - in my case it eliminated
the problem and the guest is running for months without a hiccup.
If your problem is the same, it will probably help as well.

> We're suspecting that the problem has been introduced by the
> patch [1] to stop saving the process FP state which has been
> applied just before 2.6.24-rc1.

In my case it was reproducible with 2.6.23.17 as well.

Regards
-- 
                                      Stano

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

