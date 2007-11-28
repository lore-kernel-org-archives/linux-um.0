Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxMlO-00023z-QN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 05:15:39 -0800
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxMlN-0002tB-Cu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 05:15:38 -0800
Date: Wed, 28 Nov 2007 14:15:18 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071128131518.GA3193@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] -rt doesn't compile for UML
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> > so there's no forced need to use -rt.
> 
> Ah, forgotten about that.
> 
> Unfortunately the latency tracer patch doesn't compile either:
> 
>   CC      kernel/latency_trace.o
> kernel/latency_trace.c:28:21: error: asm/rtc.h: No such file or directory
> kernel/latency_trace.c:63:3: error: #error Implement cycles_to_usecs.
> kernel/latency_trace.c: In function ???____trace???:
> kernel/latency_trace.c:658: error: implicit declaration of function ???irqs_disabled_flags???
> make[1]: *** [kernel/latency_trace.o] Error 1

hm, just fill those functions in - should be fairly trivial and we can 
carry those patches in -rt. (I'd suggest to create an empty asm-um/rtc.h 
stub as well, for consistency.)

	Ingo

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
