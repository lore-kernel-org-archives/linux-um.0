Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bl2QV-0000wz-Lg for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 02:21:15 -0700
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bl2QU-0006mu-Tn for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Jul 2004 02:21:15 -0700
Received: from [192.168.23.2] (bgm-24-94-57-251.stny.rr.com [24.94.57.251])
	by ms-smtp-04.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id
	i6F9L0t3014413 for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Jul 2004 05:21:01 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
Reply-To: rostedt@kihontech.com
Message-ID: <Pine.LNX.4.44.0407150508220.3644-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] mount_fs bug
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
Date: Thu, 15 Jul 2004 05:24:30 -0400 (EDT)
To: User Mode Linux Development <User-mode-linux-devel@lists.sourceforge.net>

Hi, 

I've been programming in the linux kernel for a few years now and I just 
started using UML, and would like to say that I've really enjoyed it, and 
thanks for the work that has been put in. I'm looking forward to working 
with it more often.

OK, enough of that, now on to the real reason I'm writing.  I've just 
downloaded the linux 2.4.26 kernel and applied the uml-patch-2.4.26-1.bz2 
patch.  I've also installed the skas patch to my 2.6.7 host kernel.

When I mounted hostfs I took a panic.  Looking into this it seems that 
host_root_filename (arch/um/fs/hostfs/externfs.c) is wrong.

Currently it is:

char *host_root_filename(char *mount_arg)
{
        char *root = DEFAULT_ROOT;

        if((mount_arg != NULL) && (*mount_arg != '\0'))
                root = mount_arg;

        return(uml_strdup(mount_arg));
}

And I believe than should end as

        return(uml_strdup(root));

Sorry I didn't apply a patch (laziness), and the change is trivial enough 
for you guys to change.

Right now (even after the change) I cant mount hostfs. I'm getting the 
error:

# mount -t hostfs none /mnt/host/
mount: wrong fs type, bad option, bad superblock on hostfs,
       or too many mounted file systems

But I'm looking into this too, and unless you already know the reason and 
have a patch or something, I'll be working on it. 

Thanks,

-- Steve





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
