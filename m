Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HglZO-0003td-Kl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 10:46:25 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HglZJ-00012x-Ug
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 10:46:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 25 Apr 2007 17:51:10 +0200
References: <11774247864122-git-send-email-albertito@gmail.com>
In-Reply-To: <11774247864122-git-send-email-albertito@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704251751.11461.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Make hostfs_setattr() support operations on
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alberto Bertogli <albertito@gmail.com>

On marted=EC 24 aprile 2007, Alberto Bertogli wrote:
> This patch allows hostfs_setattr() to work on closed files by calling
> set_attr() (the userspace part) with the inode's fd.
>
> Without this, applications that depend on doing attribute changes to
> closed files will fail.
>
> It works by using the fd versions instead of the path ones (for example
> fchmod() instead of chmod(), fchown() instead of chown()) when an fd is
> available.
>
>
> Signed-off-by: Alberto Bertogli <albertito@gmail.com>
> ---
This makes sense and is useful - but:
1) when I read the examples, I understood you meant 'unlinked open files', =

not 'closed files'. Right?

The patch is of good quality; I've not seen any single bug, which is rare i=
n=20
such submission, but before merging, some little things should be fixed up =

(either by you or by Jeff).

2) if (...) return ...; on a single line is horrible style, should be=20
corrected (I see sometimes the original code uses it, well it shouldn't).

> I was also worried about the semantics, for instance, the outcome of:
>
> 	fd =3D open("f1.tmp");
> 	write(fd, ...);
> 	link("f1.tmp", "f1");
> 	unlink("f1.tmp");
> 	fd2 =3D open("f1.tmp");
> 	fchmod(fd, 0644);

> In the host fchmod() changes f1 and not f1.tmp, but maybe the open() in t=
he
> middle got hostfs confused. Luckily this is not the case and it works fin=
e;
> but as I'm not familiar with hostfs there may be other issues.

I guess the patch would make this work, right?

> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index fd301a9..c704d9c 100644

> @@ -817,8 +817,14 @@ int hostfs_permission(struct inode *ino, int desired,
> struct nameidata *nd) int hostfs_setattr(struct dentry *dentry, struct
> iattr *attr)
>  {
>  	struct hostfs_iattr attrs;
> +	struct hostfs_inode_info *iinfo;
>  	char *name;
>  	int err;
> +	int fd =3D -1;
> +
> +	iinfo =3D HOSTFS_I(dentry->d_inode);
> +	if (iinfo !=3D NULL)
> +		fd =3D iinfo->fd;

iinfo cannot be NULL, so please remove that if. HOSTFS_I does not access a =

field of d_inode; rather, d_inode points to a field of iinfo, i.e. the=20
vfs_inode field of struct hostfs_inode_info.

>  	err =3D inode_change_ok(dentry->d_inode, attr);
>  	if (err)
> @@ -864,7 +870,7 @@ int hostfs_setattr(struct dentry *dentry, struct iattr
> *attr) }
>  	name =3D dentry_name(dentry, 0);
>  	if(name =3D=3D NULL) return(-ENOMEM);
> -	err =3D set_attr(name, &attrs);
> +	err =3D set_attr(name, &attrs, fd);
>  	kfree(name);
>  	if(err)
>  		return(err);

I do not like the below code. The different code is for setting buf; what=20
follows that is common to all cases, and the conversion probably should be =

factored out into a conversion function for better clarity: verifying what =

the code does is difficult here.

>  	ma =3D HOSTFS_ATTR_ATIME_SET | HOSTFS_ATTR_MTIME_SET;
>  	if((attrs->ia_valid & ma) =3D=3D ma){
> +		struct timeval times[2];
> +
>  		buf.actime =3D attrs->ia_atime.tv_sec;
>  		buf.modtime =3D attrs->ia_mtime.tv_sec;
> -		if(utime(file, &buf) !=3D 0) return(-errno);
> +
> +		/* atime */
> +		times[0].tv_sec =3D attrs->ia_atime.tv_sec;
> +		times[0].tv_usec =3D attrs->ia_atime.tv_nsec * 1000;
> +
> +		/* mtime */
> +		times[1].tv_sec =3D attrs->ia_mtime.tv_sec;
> +		times[1].tv_usec =3D attrs->ia_mtime.tv_nsec * 1000;
> +
> +		if(fd >=3D 0){
> +			if(futimes(fd, times) !=3D 0)
> +				return(-errno);
> +		} else if(utime(file, &buf) !=3D 0){
> +			return(-errno);
> +		}
>  	}
>  	else {
>  		struct timespec ts;
> +		struct timeval times[2];
>
>  		if(attrs->ia_valid & HOSTFS_ATTR_ATIME_SET){
>  			err =3D stat_file(file, NULL, NULL, NULL, NULL, NULL,
> -					NULL, NULL, &ts, NULL, NULL, NULL);
> +					NULL, NULL, &ts, NULL, NULL, NULL, fd);
>  			if(err !=3D 0)
>  				return(err);
>  			buf.actime =3D attrs->ia_atime.tv_sec;
>  			buf.modtime =3D ts.tv_sec;
> -			if(utime(file, &buf) !=3D 0)
> +
> +			/* atime */
> +			times[0].tv_sec =3D attrs->ia_atime.tv_sec;
> +			times[0].tv_usec =3D attrs->ia_atime.tv_nsec * 1000;
> +
> +			/* mtime */
> +			times[1].tv_sec =3D ts.tv_sec;
> +			times[1].tv_usec =3D ts.tv_nsec * 1000;
> +
> +			if(fd >=3D 0){
> +				if(futimes(fd, times) !=3D 0)
> +					return(-errno);
> +			} else if(utime(file, &buf) !=3D 0){
>  				return(-errno);
> +			}
>  		}
>  		if(attrs->ia_valid & HOSTFS_ATTR_MTIME_SET){
>  			err =3D stat_file(file, NULL, NULL, NULL, NULL, NULL,
> -					NULL, &ts, NULL, NULL, NULL, NULL);
> +					NULL, &ts, NULL, NULL, NULL, NULL, fd);
>  			if(err !=3D 0)
>  				return(err);
>  			buf.actime =3D ts.tv_sec;
>  			buf.modtime =3D attrs->ia_mtime.tv_sec;
> -			if(utime(file, &buf) !=3D 0)
> +
> +			/* atime */
> +			times[0].tv_sec =3D ts.tv_sec;
> +			times[0].tv_usec =3D ts.tv_nsec * 1000;
> +
> +			/* mtime */
> +			times[1].tv_sec =3D attrs->ia_mtime.tv_sec;
> +			times[1].tv_usec =3D attrs->ia_mtime.tv_nsec * 1000;
> +
> +			if(fd >=3D 0){
> +				if(futimes(fd, times) !=3D 0)
> +					return(-errno);
> +			} else if(utime(file, &buf) !=3D 0){
>  				return(-errno);
> +			}
>  		}
>  	}
>  	if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
>  	if(attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)){
>  		err =3D stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
>  				&attrs->ia_atime, &attrs->ia_mtime, NULL,
> -				NULL, NULL);
> +				NULL, NULL, fd);
>  		if(err !=3D 0) return(err);
>  	}
>  	return(0);



--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

