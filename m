Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AO3VR-0003He-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 15:19:05 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AO3VQ-00055C-SZ
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 23 Nov 2003 15:19:04 -0800
Subject: Re: [uml-devel] Host panic when UML reads host /dev/shm
Message-ID: <20031123.150830.-1747969.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 23 Nov 2003 15:08:27 -0800
To: user-mode-linux-devel@lists.sourceforge.net

I have been tracing down the Oops on a vanilla 2.4.22 kernel
This appears to be a Oops with a semaphore held that will
lock out all other accesses to the tmpfs/shmfs filesystem.

I traced it to read_dir in hostfs_user.c by setting
breakpoints on all the hostfs_user.c functions.

Ok I now have a simple test program which Oops
the host kernel instantly (3 times through loop)

This is very strange my attached test program when run
as a unprivileged user Oops the kernel and locks /dev/shm
in general a unprivileged user should not be able to do this

It has taken a while in order to check that the kernel I was
running was without patches (i.e. no skas)
It still Oops on the third loop :(

I have also noted that the tmpfs/shmfs does not have a set
of files like other filesystems under fs/ it seems to be located
in mm/shmem.c instead... very strange

Oh well it is a problem with the vanilla 2.4.22 kernel so
more testing and off to the LKML...

Anybody have a better guess where to send this?

For your Enjoyment the test program

/* by James_McMechan at hotmail com */
/* test program to Oops shmfs usually mounted at /dev/shm */
/* yes it is dumb but unprivileged users should not be able */
/* to Oops the kernel regardless of how dumb the program */
#include <sys/types.h>                                                   
      
#include <dirent.h>
#include <stdio.h>

main()
{
        DIR *dir;
        struct dirent *ent;
        off_t pos = 0;

        do {
                dir = opendir("/dev/shm");
                seekdir(dir, pos);
                ent = readdir(dir);
                if (ent == 0) {
                        printf("end of directory\n");
                        perror("readdir ended with");
                } else {
                        printf("d_name is %s\n",ent->d_name);
                        pos = telldir(dir);
                        if (pos < 0)
                                perror("telldir failed with");
                }
                closedir(dir);
        } while (ent != 0);
}

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
