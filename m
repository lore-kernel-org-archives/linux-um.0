Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bnmkr-0005jg-UH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 16:13:37 -0700
Received: from hfuhruhurr.iostream.com ([209.212.93.20])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bnmkr-0004Il-H1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 16:13:37 -0700
Received: from uumellmahaye (uumellmahaye [209.212.93.19])
	by hfuhruhurr.iostream.com (8.12.8/8.12.8) with ESMTP id i6MNDXS3009555
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jul 2004 19:13:34 -0400
From: Jinnah Dylan Hosein <jdh66+spam@jdh.org>
Message-ID: <Pine.LNX.4.44.0407221901400.1382-100000@hfuhruhurr.iostream.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] I ported skas3 to fc2 kernel
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
Date: Thu, 22 Jul 2004 19:13:33 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

I ported the host-skas3-2.6.7-v1.patch to the Fedora Core 2 kernel.

I used the latest fc2 2.6.6-1.435.2.3 kernel rpm.

I've tested it and I was able to run a 2.4.19 uml kernel with a redhat 
7.2 rootfs. I wasn't able to make it leak memory by running the "while 
true" bash line, but I don't understand exactly what triggers the leak so 
it's likely I didn't properly test.

I don't do a lot of coding so I probably made some stupid mistakes. But 
I needed skas3 on Fedora Core 2 so I went ahead and tried porting the 
patch.

I just saw that BlaisorBlade sent a patch to fix the memory leak. I'll see 
if I can add that to my modification.

Hopefully others may find this useful.

You can get the details here:
http://jdh.org/uml/

My patchfile is here:
http://jdh.org/uml/host-skas3-2.6.6-1.435.2.3.patch

I'm not hosting a modified src.rpm because it would just be too large a 
file to have people downloading. But it's easy to modify the existing 
src.rpm from fedora.

Let me know if this is useful or broken.

Keep up the good work,

-jdh



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
