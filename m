Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] A quick humfs HOWTO
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
Date: Wed, 07 Apr 2004 22:07:52 -0400
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

As the readers of uml-devel are aware by now, there is a new virtual UML 
filesystem called humfs.  This is a hostfs-like filesystem which does ownerships
right, by separating them from the actual file, ala umsdos.

The reasons for humfs are described in my latest diary entry at 
	http://user-mode-linux.sourceforge.net/diary.html

This post describes how it works, and how to set it up.  This will be expanded
upon and added to the UML site.

Unlike a hostfs-mounted directory, a humfs filesystem has a definite root, and
must be prepared ahead of time.  There is a tool in the latest uml_utilities
called humfsify which does this for you, so don't use the following description
to set one up by hand.

The root contains two directories :
	data - which contains the files
	metadata - which shadows "data" and whose files contain ownership 
		information
and one file
	superblock - which contains information about the filesystem as a 
		whole

For plain files, the corresponding metadata file has the format
	"<uid> <gid>\n"
i.e. "0 0\n" for a uid root, gid root file.

For directories, the format is the same, except that ownership is in the 
"metadata" file in its metadata directory.  In the event that there is a real
"metadata" file, its ownerships will be on the second line of that file.

For example, the directory /foo/bar/ has both data/foo/bar/ and metadata/foo/bar
directories.  Its ownerships are in the file metadata/foo/bar/metadata.  If
there is a /foo/bar/metadata, then its ownerships are also in that file, which
would then look like
	"<directory uid> <directory gid>\n<file uid> <file gid>\n"

This second line thing isn't implemented yet, so don't go creating files called
metadata just now.

For character and block devices the data file exists, but is empty, and the
metadata file has the format
	"<uid> <gid> <type> <major> <minor>\n"

uid and gid are as above.  major and minor are self-explanatory.  type is
either of the characters 'b' and 'c', depending on whether it's a block or
character device.

Unix sockets are similar, except they have no major and minor numbers, and
have a type of 's' :
	"<uid> <gid> s\n"

The superblock file has the format
	"version <number>\nused <number>\ntotal <number>\n"

The version is currently 1.  used is set to the disk space consumed by 
everything in the data directory.  total is set arbitrarily when you set
up the filesystem.  It is the size of the filesystem as seen within UML.

humfsify is in the uml_utilities tarball in ./humfsify/humfsify.  Before running
it, you need to create an empty directory, then copy the filesystem you want
to mount to the "data" subdirectory of the new directory.  cd to the new
directory, and run humfsify as root:
	humfsify <user> <group> <size>

user and group are the uid and gid that UML will be running as, respectively.
size is the size of the filesystem as seen inside UML, specified in bytes.
The suffixes "K", "M", and "G" are accepted, and have the obvious meanings.

humfsify will walk the "data" hierarchy and create the "metadata" hierarchy
and the superblock file.

Once this is done, it is ready for use a UML which is version 2.4.24-2 or later.
To boot UML on this, enable CONFIG_HUMFS, and replace the ubd0=... argument
with 
	root=/dev/root rootflags=<path to humfs root> rootfstype=humfs

UML will boot as it usually does, and you will see a humfs rootfilesystem
when you log in.  All file operations should work as usual, and you should
be able to create files owned by multiple different users and have those
ownerships preserved.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
