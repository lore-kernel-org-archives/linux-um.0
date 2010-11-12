Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1PGzJo-00023a-1o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2010 19:29:52 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGzJk-0007GR-0o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2010 19:29:52 +0000
Date: Fri, 12 Nov 2010 11:29:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20101112112904.4b91d140.akpm@linux-foundation.org>
In-Reply-To: <1289517488-17628-1-git-send-email-richard@nod.at>
References: <1289517488-17628-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: mark CONFIG_HIGHMEM as broken
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
To: Richard Weinberger <richard@nod.at>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, 12 Nov 2010 00:18:08 +0100
Richard Weinberger <richard@nod.at> wrote:

> Currently CONFIG_HIGHMEM is broken on User Mode Linux.
> I'm not sure if it worked ever.
> 

What is "broken" about it?


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

