Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxMNK-0007vO-4g for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 04:50:46 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxMNI-0007Fe-Pp
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 04:50:46 -0800
Date: Wed, 28 Nov 2007 13:50:30 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071128125030.GB21791@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
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

> When writing a big file to a ubd disk, everything in uml slows down to
> a crawl, even though CPU usage is minimal.
> 
> So I wanted to try the latency tracer from -rt, but it doesn't compile 
> with UML:

note that there are standalone patches as well:

 http://people.redhat.com/mingo/latency-tracing-patches/

so there's no forced need to use -rt.

> Ingo, do you think this route is worthwhile pursuing, or is it too 
> difficult to make -rt work for UML?

-rt should work for UML as well - but it needs porting (as every 
architecture).

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
