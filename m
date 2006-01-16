Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EybIs-0001Xy-NY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 12:50:14 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EybIr-0000Ky-9A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 12:50:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 46B0B457D6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Jan 2006 20:50:01 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04508-05 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Mon, 16 Jan 2006 20:49:58 +0000 (GMT)
Received: from [192.168.0.6] (host-87-74-58-135.bulldogdsl.com [87.74.58.135])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 865CA457B0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 Jan 2006 20:49:58 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1137444603.8036.2.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.15-rc1 Badness in handle_page_fault
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
Date: Mon, 16 Jan 2006 20:50:03 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Found these in a guest running 2.6.15-rc1.
Note sure this is relevant anymore, but here it is anyway:

[45512066.140000] Badness in handle_page_fault at
arch/um/kernel/trap_kern.c:101
[45512066.140000] a52ebb90:  [<a0022b4e>] handle_page_fault+0x2ae/0x2c0
[45512066.140000] a52ebbbc:  [<a0022e59>] segv+0x1b9/0x320
[45512066.140000] a52ebbdc:  [<a0058de1>] activate_task+0x71/0x90
[45512066.140000] a52ebc04:  [<a004e76d>] wait_stub_done+0x5d/0x170
[45512066.140000] a52ebc24:  [<a00a44c2>] filp_close+0x52/0x90
[45512066.140000] a52ebc3c:  [<a00a4573>] sys_close+0x73/0x80
[45512066.140000] a52ebc54:  [<a002732e>] handle_syscall+0x12e/0x1c0
[45512066.140000] a52ebc6c:  [<a0022c1f>] segv_handler+0xbf/0x140
[45512066.140000] a52ebc94:  [<a004f961>] user_signal+0x51/0x80
[45512066.140000] a52ebca8:  [<a004f636>] userspace+0x1e6/0x3a0
[45512066.140000] a52ebd08:  [<a0026f12>] fork_handler+0xd2/0x100
[45512066.140000] a52ebd5c:  [<a0462f81>] kill+0x11/0x20
[45512066.140000]
[45512066.830000] load_TLS(O_FORCE) in fork_handler returned -2
[45512067.820000] Badness in handle_page_fault at
arch/um/kernel/trap_kern.c:101
[45512067.820000] a52ebb90:  [<a0022b4e>] handle_page_fault+0x2ae/0x2c0
[45512067.820000] a52ebbbc:  [<a0022e59>] segv+0x1b9/0x320
[45512067.820000] a52ebbe8:  [<a00c4a32>] mntput_no_expire+0x22/0x90
[45512067.820000] a52ebc04:  [<a004e76d>] wait_stub_done+0x5d/0x170
[45512067.820000] a52ebc24:  [<a00a44c2>] filp_close+0x52/0x90
[45512067.820000] a52ebc3c:  [<a00a4573>] sys_close+0x73/0x80
[45512067.820000] a52ebc54:  [<a002732e>] handle_syscall+0x12e/0x1c0
[45512067.820000] a52ebc6c:  [<a0022c1f>] segv_handler+0xbf/0x140
[45512067.820000] a52ebc94:  [<a004f961>] user_signal+0x51/0x80
[45512067.820000] a52ebca8:  [<a004f636>] userspace+0x1e6/0x3a0
[45512067.820000] a52ebd08:  [<a0026f12>] fork_handler+0xd2/0x100
[45512067.820000] a52ebd5c:  [<a0462f81>] kill+0x11/0x20
[45512067.820000]
[45512068.490000] load_TLS(O_FORCE) in fork_handler returned -2
[45512070.120000] load_TLS(O_FORCE) in fork_handler returned -2
[45512070.890000] load_TLS(O_FORCE) in fork_handler returned -2
[45512070.890000] load_TLS(O_FORCE) in fork_handler returned -2
[45512073.140000] load_TLS(O_FORCE) in fork_handler returned -2
[45512073.140000] load_TLS(O_FORCE) in fork_handler returned -2
[45512074.110000] load_TLS(O_FORCE) in fork_handler returned -2
[45512075.100000] load_TLS(O_FORCE) in fork_handler returned -2
[45512075.890000] load_TLS(O_FORCE) in fork_handler returned -2
[45512080.480000] load_TLS(O_FORCE) in fork_handler returned -2
[45512080.480000] load_TLS(O_FORCE) in fork_handler returned -2
[45512082.000000] load_TLS(O_FORCE) in fork_handler returned -2
[45512082.230000] load_TLS(O_FORCE) in fork_handler returned -2
[45512091.260000] load_TLS(O_FORCE) in fork_handler returned -2
[45512097.510000] load_TLS(O_FORCE) in fork_handler returned -2
[45512097.590000] load_TLS(O_FORCE) in fork_handler returned -2
[45512097.590000] load_TLS(O_FORCE) in fork_handler returned -2
[45512103.120000] load_TLS(O_FORCE) in fork_handler returned -2
[45512104.320000] load_TLS(O_FORCE) in fork_handler returned -2
[45512109.940000] load_TLS(O_FORCE) in fork_handler returned -2
[45512109.940000] load_TLS(O_FORCE) in fork_handler returned -2
[45512109.940000] load_TLS(O_FORCE) in fork_handler returned -2
[45512113.300000] uml_net_start_xmit: failed(-1)
[45512116.580000] load_TLS(O_FORCE) in fork_handler returned -2

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
