Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgszp-0004Je-LB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 18:42:10 -0700
Received: from wx-out-0506.google.com ([66.249.82.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgszp-0004DW-19
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 18:42:09 -0700
Received: by wx-out-0506.google.com with SMTP id i30so774616wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 18:42:08 -0700 (PDT)
Date: Wed, 25 Apr 2007 22:43:07 -0300
From: Alberto Bertogli <albertito@gmail.com>
Message-ID: <20070426014307.GE31191@gmail.com>
References: <11774247864122-git-send-email-albertito@gmail.com>
	<200704251751.11461.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200704251751.11461.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Make hostfs_setattr() support operations	on
	closed files.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 25, 2007 at 05:51:10PM +0200, Blaisorblade wrote:
> On marted=EC 24 aprile 2007, Alberto Bertogli wrote:
> > This patch allows hostfs_setattr() to work on closed files by calling
> > set_attr() (the userspace part) with the inode's fd.
> >
> > Without this, applications that depend on doing attribute changes to
> > closed files will fail.
> >
> > It works by using the fd versions instead of the path ones (for example
> > fchmod() instead of chmod(), fchown() instead of chown()) when an fd is
> > available.
> >
> >
> > Signed-off-by: Alberto Bertogli <albertito@gmail.com>
> > ---
> This makes sense and is useful - but:
> 1) when I read the examples, I understood you meant 'unlinked open files'=
,=20
> not 'closed files'. Right?

Right, sorry about that, the terminology I used is completely
misleading. I'll change the description.


> The patch is of good quality; I've not seen any single bug, which is rare=
 in=20
> such submission, but before merging, some little things should be fixed u=
p=20
> (either by you or by Jeff).
>=20
> 2) if (...) return ...; on a single line is horrible style, should be=20
> corrected (I see sometimes the original code uses it, well it shouldn't).

I couldn't agree more. I did it that way because I tried to follow the
coding style of the original code.


> > In the host fchmod() changes f1 and not f1.tmp, but maybe the open() in=
 the
> > middle got hostfs confused. Luckily this is not the case and it works f=
ine;
> > but as I'm not familiar with hostfs there may be other issues.
>=20
> I guess the patch would make this work, right?

Yes, that case works with the patch.


> > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > index fd301a9..c704d9c 100644
>=20
> > @@ -817,8 +817,14 @@ int hostfs_permission(struct inode *ino, int desir=
ed,
> > struct nameidata *nd) int hostfs_setattr(struct dentry *dentry, struct
> > iattr *attr)
> >  {
> >  	struct hostfs_iattr attrs;
> > +	struct hostfs_inode_info *iinfo;
> >  	char *name;
> >  	int err;
> > +	int fd =3D -1;
> > +
> > +	iinfo =3D HOSTFS_I(dentry->d_inode);
> > +	if (iinfo !=3D NULL)
> > +		fd =3D iinfo->fd;
>=20
> iinfo cannot be NULL, so please remove that if. HOSTFS_I does not access =
a=20
> field of d_inode; rather, d_inode points to a field of iinfo, i.e. the=20
> vfs_inode field of struct hostfs_inode_info.

That's good to know =3D) I'll fix it.


> I do not like the below code. The different code is for setting buf; what=
=20
> follows that is common to all cases, and the conversion probably should b=
e=20
> factored out into a conversion function for better clarity: verifying wha=
t=20
> the code does is difficult here.

I agree. I tried to make the changes to look as much as possible to the
original, but if you want me to reorganize that code a bit, I'll be glad
to give it a try.


I'll address all these issues and post and updated patch (probably
tomorrow).

Thanks a lot,
		Alberto



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

