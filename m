Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+bd89cdb79a39dfa2a8f1+4161+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1YBJUg-0008Sv-MI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Jan 2015 08:40:02 +0000
Received: from bombadil.infradead.org ([198.137.202.9])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YBJUf-0005jz-8h
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Jan 2015 08:40:02 +0000
Date: Wed, 14 Jan 2015 00:39:51 -0800
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20150114083951.GA29714@infradead.org>
References: <1421187358-32600-1-git-send-email-richard@nod.at>
	<20150113221958.GA27739@infradead.org> <54B59B9E.4000806@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54B59B9E.4000806@nod.at>
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
Subject: Re: [uml-devel] [PATCH] hostfs: Use noop_fsync for directories
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org

On Tue, Jan 13, 2015 at 11:26:38PM +0100, Richard Weinberger wrote:
> hostfs tries do reduce the amount of syscall between guest and host as much
> as possible. For file operations it passes everything down to the host but
> for directory operations only ->iterate() does.
> 
> It is already horrible slow, if we add an ->open() for directory too it would
> get even more slower. :-(

This sounds fairlt dangerous.  At least add some good documentation
explaining these semantics.


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

