Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfhW-0001xQ-Lw
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:42:39 +0000
Received: by mail-wr1-x442.google.com with SMTP id p10so18866719wrt.6
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200320130735.50925-1-andriy.shevchenko@linux.intel.com>
 <20200324123644.GJ1922688@smile.fi.intel.com>
In-Reply-To: <20200324123644.GJ1922688@smile.fi.intel.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:42:26 +0200
Message-ID: <CAFLxGvyEri=M+KQbd-46gQd_Qzrd_W85CzxZh5woJ+HdCFoCtg@mail.gmail.com>
Subject: Re: [PATCH v1] hostfs: Use kasprintf() instead of fixed buffer
 formatting
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Mar 24, 2020 at 1:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 20, 2020 at 03:07:35PM +0200, Andy Shevchenko wrote:
> > Improve readability and maintainability by replacing a hardcoded string
> > allocation and formatting by the use of the kasprintf() helper.
> >
>
> Any comments so far?
>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  fs/hostfs/hostfs_kern.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > index e6b8c49076bb..c070c0d8e3e9 100644
> > --- a/fs/hostfs/hostfs_kern.c
> > +++ b/fs/hostfs/hostfs_kern.c
> > @@ -139,8 +139,8 @@ static char *inode_name(struct inode *ino)
> >
> >  static char *follow_link(char *link)
> >  {
> > -     int len, n;
> >       char *name, *resolved, *end;
> > +     int n;
> >
> >       name = __getname();
> >       if (!name) {
> > @@ -164,15 +164,13 @@ static char *follow_link(char *link)
> >               return name;
> >
> >       *(end + 1) = '\0';
> > -     len = strlen(link) + strlen(name) + 1;
> >
> > -     resolved = kmalloc(len, GFP_KERNEL);
> > +     resolved = kasprintf(GFP_KERNEL, "%s%s", link, name);
> >       if (resolved == NULL) {
> >               n = -ENOMEM;
> >               goto out_free;
> >       }
> >
> > -     sprintf(resolved, "%s%s", link, name);
> >       __putname(name);
> >       kfree(link);
> >       return resolved;
> > @@ -921,18 +919,16 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
> >       sb->s_d_op = &simple_dentry_operations;
> >       sb->s_maxbytes = MAX_LFS_FILESIZE;
> >
> > -     /* NULL is printed as <NULL> by sprintf: avoid that. */
> > +     /* NULL is printed as '(null)' by printf(): avoid that. */
> >       if (req_root == NULL)
> >               req_root = "";
> >
> >       err = -ENOMEM;
> >       sb->s_fs_info = host_root_path =
> > -             kmalloc(strlen(root_ino) + strlen(req_root) + 2, GFP_KERNEL);
> > +             kasprintf(GFP_KERNEL, "%s/%s", root_ino, req_root);
> >       if (host_root_path == NULL)
> >               goto out;
> >
> > -     sprintf(host_root_path, "%s/%s", root_ino, req_root);
> > -
> >       root_inode = new_inode(sb);
> >       if (!root_inode)
> >               goto out;

Thanks for cleaning this up! Applied.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

