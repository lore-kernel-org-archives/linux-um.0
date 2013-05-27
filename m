Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rob@landley.net>) id 1Uh5NG-0005Oe-86
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 May 2013 21:54:38 +0000
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uh5ND-0001du-9d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 May 2013 21:54:38 +0000
Received: by mail-oa0-f54.google.com with SMTP id o17so9260670oag.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 May 2013 14:54:29 -0700 (PDT)
Date: Mon, 27 May 2013 16:27:45 -0500
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAFLxGvy_SvjdTJ97DtCFubUAPgJ4tSgZi8LFYNHEwN94cUZLFQ@mail.gmail.com>
	(from richard.weinberger@gmail.com on Sun May 26 03:08:17 2013)
Message-Id: <1369690065.2776.33@driftwood>
MIME-Version: 1.0
Content-Disposition: inline
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
Subject: Re: [uml-devel] How is Preemption implemented in User Mode Linux?
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 05/26/2013 03:08:17 AM, richard -rw- weinberger wrote:
> On Sun, May 26, 2013 at 1:01 AM, Hopsing K <hopsingk@gmail.com> wrote:
> > Some question at the side: can you call longjmp from within a signal
> > handler? My first assumption was that UML uses longjmp from within
> > the SIGALRM handler to implement preemption, butseems not to .

Yes, "man longjmp" shows you sigsetjmp() and siglongjmp(), which save  
and restore the signal mask. This is an important detail because the  
signal you're handling is disabled in the signal handler (to avoid an  
infinite loop). You can just setjmp() and longjmp() and fiddle with the  
signal mask yourself, but signals can nest (a different signal can  
interrupt a signal handler) so re-enabling just one may not be enough.

On return, the kernel re-enables the signal you were handling, even  
from nested signal handlers. But if you longjmp() you don't call the  
kernel return code...

Rob
------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

