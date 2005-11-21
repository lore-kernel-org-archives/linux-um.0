Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ee75I-00062U-Ez for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 00:31:32 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ee75H-0007Ed-07
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Nov 2005 00:31:32 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jALA5Xis011774
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 21 Nov 2005 05:05:37 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511210019.36848.rob@landley.net>
Subject: [uml-devel] Do we care about 4k stacks?
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
Date: Mon, 21 Nov 2005 00:19:36 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Just curious if this is at all relevant to us, in light of the "yank 8k 
stacks" patch proposed...

$ make checkstack
objdump -d vmlinux $(find . -name '*.ko') | \
perl /home/landley/linux-2.6.15-rc1/scripts/checkstack.pl i386
0xa010ddcf buffered_vfprintf:                           33168
0xa010deca buffered_vfprintf:                           33168
0xa00e5d5b buffered_vfprintf:                           8416
0xa00e5e43 buffered_vfprintf:                           8416
0xa0121ffb __res_vinit:                                 8256
0xa012293a __res_vinit:                                 8256
0xa011199c phys_pages_info:                             8212
0xa01117bf __get_nprocs:                                8208
0xa010a426 _IO_vfwprintf:                               4376
0xa00ebe33 _IO_wfile_seekoff:                           4280
0xa00ec0b9 _IO_wfile_seekoff:                           4280
0xa00f8626 __unix_grantpt:                              4252
0xa00f848f grantpt:                                     4188
0xa01103c6 execle:                                      4140
0xa0005119 make_uml_dir:                                4124
0xa00051bd make_uml_dir:                                4124
0xa0023dc0 make_tempfile:                               4124
0xa0023e5a make_tempfile:                               4124
0xa00e01d7 openpty:                                     4124
0xa011cd40 _dl_get_origin:                              4112
0xa011cdc4 _dl_get_origin:                              4112

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
