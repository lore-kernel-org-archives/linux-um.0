Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FR4pu-0007ZI-EJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 03:02:02 -0700
Received: from [84.204.75.166] (helo=shelob.oktetlabs.ru)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FR4ps-0007V9-Vz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 03:02:02 -0700
Received: from [192.168.37.19] (gimli.oktetlabs.ru [192.168.37.19])
	by shelob.oktetlabs.ru (Postfix) with ESMTP id 0539E4747B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  5 Apr 2006 14:01:52 +0400 (MSD)
Message-ID: <4433958F.3090200@oktetlabs.ru>
From: "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] find_iomem hangs up
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
Date: Wed, 05 Apr 2006 14:01:51 +0400
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

When I've build uml with mmapper driver in, and attempted to pass 
something like iomem=xxx,yyy in command line, guest kernel hang up on 
boot. This is because of error in find_iomem - see patch below.

Victor

Index: linux-2.6.15.4.x/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.15.4.x/arch/um/kernel/physmem.c   (revision 23)
+++ linux-2.6.15.4.x/arch/um/kernel/physmem.c   (revision 24)
@@ -408,6 +408,7 @@
                        *len_out = region->size;
                        return(region->virt);
                }
+               region = region->next;
        }

        return(0);

-- 
Victor Vengerov
OKTET Labs, St.-Petersburg, Russia   Web: www.oktetlabs.ru
Phone +7 812 4286709(office) +7 812 9389372(mobile) +7 812 4281653(home)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
