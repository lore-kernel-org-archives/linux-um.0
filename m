Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1QyBGl-0005vK-Uw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 23:29:31 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QyBGl-0000JX-2v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 23:29:31 +0000
Message-ID: <4E5C20A7.9040603@panasas.com>
Date: Mon, 29 Aug 2011 16:28:39 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1314634419-24766-1-git-send-email-richard@nod.at>
	<1314634419-24766-9-git-send-email-richard@nod.at>
	<20110829142705.5be82d7c.akpm@linux-foundation.org>
	<4E5C06DF.60508@nod.at> <20110829221230.GP2203@ZenIV.linux.org.uk>
	<4E5C0F9F.5000405@nod.at>
	<20110829221922.GQ2203@ZenIV.linux.org.uk>
	<4E5C11D5.4020404@nod.at>
In-Reply-To: <4E5C11D5.4020404@nod.at>
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
Subject: Re: [uml-devel] [PATCH 8/9] um: fix strrchr problems
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ftp.linux.org.uk>, Al Viro <viro@ZenIV.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On 08/29/2011 03:25 PM, Richard Weinberger wrote:
>>
>> Try to build it static...
> 
> I'm building most of the time static.
> Using defconfig and
> CONFIG_STATIC_LINK=y
> it builds fine here (x86_64 and i386)
> 
> Thanks,
> //richard

With some switches and optimization gcc might turn strrchr
into a built-in inline.

What option turns off all optimizations? It might fail then.

Boaz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

