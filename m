Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DHEi3-0001w1-7g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 21:28:43 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DHEi1-0004LK-8Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 21:28:43 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [patch 03/12] uml: export getgid for hostfs
References: <20050322162123.890086BA6F@zion>
	<200503302005.26311.blaisorblade@yahoo.it>
	<20050331144026.GA18248@infradead.org>
In-Reply-To: <20050331144026.GA18248@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503312324.41299.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 31 Mar 2005 23:24:40 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Christoph Hellwig <hch@infradead.org>, Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Thursday 31 March 2005 09:40 am, Christoph Hellwig wrote:
> > Sorry, I wasn't clear... I read *that* answer, but it says "as mentioned
> > in the discussion about ROOT_DEV", and I couldn't find it.
>
> That'd be:
>
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110664428918937&w=2

As the only user who seems to be crazy enough to regularly run UML with a 
hostfs root (ala "./linux rootfstype=hostfs rw init=/bin/sh"), I'd just like 
to say that I'm fairly certain I'm _not_ using ROOT_DEV special casing (my 
root files actually do belong to root, I'm just borrowing the parent's 
filesystem to avoid the trouble of setting up a whole filesystem under 
loopback.)

And actually, the ROOT_DEV hack wouldn't help me, because my project is using 
a dirty trick where I make a loopback mounted ext2 image (which could easily 
be ramfs or tmpfs if my project didn't need 500 megs of scratch space), 
--bind mount all the directories from the parent I need into it, and chroot 
into it.  (Thus I have the parent's binaries and libraries, but the rest is 
writeable space I can mknod and chown and such in.)  This is done with a 
trivial shell script, the guts of which are:

-----------------------
for i in /*
do
  i="${i:1}"
  if [ "$i" != "lost+found" ]
  then
    if [ -h "$i" ]
    then
      # Copy symlinks
      ln -s `readlink "$i"` "$i"
    elif [ -d "/$i" ]
    then
      # Bind mount directories
      mkdir "$i" &&
      mount -n -o bind "/$i" "$i"
    fi
  fi
  if [ $? -ne 0 ]; then exit 1; fi
done
# Don't use system /tmp, use a tmp in workspace.img.
umount tmp
mount -n -t devpts /dev/pts dev/pts
--------------------

With that, the hostfs might as well be read-only.

And as you can see, the above will very much NOT work with anything that cares 
about ROOT_DEV, since ROOT_DEV gets chrooted away fairly quickly... 

> > Also, I'd like to know whether there's a correct way to implement this
> > (using something different than root_dev, for instance the init[1] root
> > directory mount device). I understand that with the possibility for
> > multiple mounts the "root device" is more difficult to know (and maybe
> > this is the reason for which ROOT_DEV is bogus, is this?), but at least a
> > check on the param "rootfstype=hostfs" could be done.
>
> personally I think it's a bad misfeature by itself.  If you absolutely
> want it make it a mount option so it's explicit at least.

If it's going to have it at all, then yes it should be done the way.  Lots of 
filesystems have something close to this (The affs uid= and gid= options 
aren't that far off, for example.)

I'd like to point out that hostfs's rootflags= parsing needs an update.  Right 
now, it sets the path to the parent directory hostfs is to mount from, 
period.  (If omitted, the default is "rootflags=/".)  Appending something 
like ,rw gets treated as part of the path, so right now turning this feature 
on would require a remount after UML came up.

Unless it's ALWAYS the default that a hostfs mount turns files belonging to 
the user running UML into files belonging to root.  It's possible that this 
is really the intended behavior, by the way.  Whether the mount point is 
ROOT_DEV or not is probably irrelevant.

Then again, I haven't personally needed this behavior yet.  Mounting hostfs 
when UML is run by a non-root user means I can't mknod or chown, no matter 
what ownership or permissions the directory I'm in has.  And THAT is 
something that means I have to supplement hostfs with a loopback mount to get 
real writeable space in which I can get anything major done.  Making files 
look like they belong to root is a purely cosmetic change under those 
circumstances.

> And yes, the only place where ROOT_DEV makes sense is in the early boot
> process where the first filesystem in the first namespace is mounted,
> that's why I want to get rid of the export to modules for it.
>
> > Ok, this is nice. I'll repost the (updated) patch CC'ing Ingo Molnar
> > (unless there's another Ingo).
>
> Yupp, mingo

Is anyone, anywhere, actually USING this?  I'm using hostfs root fairly 
extensively and _not_ using the funky ownership rewriting feature.  Is this 
something people thought might be needed, or is somewhere somewhere actually 
inconvenienced by the lack?

Rob


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
