Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1P7vug-0001Sv-TF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 20:02:30 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P7vuf-0005ud-Iq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 20:02:30 +0000
Date: Mon, 18 Oct 2010 13:02:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20101018130208.7b552527.akpm@linux-foundation.org>
In-Reply-To: <201010182053.58496.richard@nod.at>
References: <1287419814-20086-1-git-send-email-richard@nod.at>
	<20101018114039.503233da.akpm@linux-foundation.org>
	<201010182053.58496.richard@nod.at>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/1] hostfs: fix UML crash
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
Cc: Arnd Bergmann <arnd@arndb.de>, user-mode-linux-devel@lists.sourceforge.net, toralf.foerster@gmx.de, jdike@addtoit.com, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Christoph Hellwig <hch@lst.de>

On Mon, 18 Oct 2010 20:53:58 +0200
Richard Weinberger <richard@nod.at> wrote:

> Am Montag 18 Oktober 2010, 20:40:39 schrieb Andrew Morton:
> > On Mon, 18 Oct 2010 18:36:54 +0200 Richard Weinberger <richard@nod.at> 
> wrote:
> > > 365b1818 resized f_spare within struct statfs.
> > > hostfs accesses f_spare directly and needs an update.
> > > 
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > Reported-by: Toralf F__rster <toralf.foerster@gmx.de>
> > > Tested-by: Toralf F__rster <toralf.foerster@gmx.de>
> > > ---
> > > 
> > >  fs/hostfs/hostfs_user.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> > > index 6777aa0..ce2f168 100644
> > > --- a/fs/hostfs/hostfs_user.c
> > > +++ b/fs/hostfs/hostfs_user.c
> > > @@ -388,6 +388,6 @@ int do_statfs(char *root, long *bsize_out, long long
> > > *blocks_out,
> > > 
> > >  	spare_out[1] = buf.f_spare[1];
> > >  	spare_out[2] = buf.f_spare[2];
> > >  	spare_out[3] = buf.f_spare[3];
> > > 
> > > -	spare_out[4] = buf.f_spare[4];
> > > +
> > > 
> > >  	return 0;
> > >  
> > >  }
> > 
> > Thanks.
> > 
> > Is there any reason for hostfs to be playing with the f_spare field at all?
> 
> I'm not sure why hostfs is using this field.
> Currently I'm reviewing UML. 
> As soon I'm done with hostfs you'll receive a patch or an explanation. :-)

365b1818 added f_flags to `struct statfs' but didn't carry that over to
`struct compat_statfs' and hence didn't copy f_flags over into
compat_statfs.  Deliberate, or oversight?


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

