Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J111I-0002vI-Pw for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 06:51:08 -0800
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J111I-0001DE-Hh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 06:51:08 -0800
Received: by wa-out-1112.google.com with SMTP id k22so2304461waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 08 Dec 2007 06:51:08 -0800 (PST)
Message-ID: <ea9232d10712080651g133631bcxd001c2f0d53712c8@mail.gmail.com>
Date: Sat, 8 Dec 2007 15:51:08 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
In-Reply-To: <20071208141753.GA4667@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <20071208141753.GA4667@c2.user-mode-linux.org>
Subject: Re: [uml-devel] SKAS3 for 2.6.23
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: greg@enjellic.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 08/12/2007, Jeff Dike <jdike@addtoit.com> wrote:
> A skas3 patch which works on 2.6.23 is below.  There were a couple of
> problems that I fixed which are described in the changelog.  With
> this on the host and a UML close to what's currently in -mm, I get ~85%
> of native performance on a kernel build.  With skas0, the best I've
> seen is ~75%.
>
> Thanks to greg@enjellic.com for sending me a patch that patched
> cleanly into 2.6.23.
>
> 2.6.24 is going to be even more interesting, given the x86 merge.
>
>                                 Jeff

This has just made my day. I just wish I had access to my main work machine now.
I can't wait to test this.

Karol Swietlicki

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
