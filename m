Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1u52-00051H-Ug	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Aug 2005 15:57:20 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E1u51-00031J-UD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Aug 2005 15:57:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 99E792881C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun,  7 Aug 2005 15:57:16 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
 by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18812-02 for <user-mode-linux-devel@lists.sourceforge.net>;
 Sun,  7 Aug 2005 15:57:14 -0700 (PDT)
Received: from sterling (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 6A27C2881A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun,  7 Aug 2005 15:57:14 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Message-ID: <CBELIFGMBIEPIEOFCJFAGEIPCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 'soft lockup' issue on shutdown
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
Date: Sun, 7 Aug 2005 15:57:48 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

I've been encountering a "freeze" on shutdown with guest kernel
2.6.12-rc5-mm1. Today, I was busy with other things so I left it frozen for
a while. When I returned, I saw the following:

Turning off swap
BUG: soft lockup detected on CPU#0!

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
082976f0:  [<080789a9>] show_regs+0xc9/0xf0
08297710:  [<0809bb60>] softlockup_tick+0x50/0x60
08297730:  [<08087d44>] do_timer+0x44/0x110
08297750:  [<08062750>] um_timer+0x10/0x50
08297770:  [<0809bd86>] handle_IRQ_event+0x36/0x90
082977a0:  [<0809be8e>] __do_IRQ+0xae/0x110
082977c0:  [<0805f2df>] do_IRQ+0x2f/0x40
082977d0:  [<080626cb>] timer_irq+0x11b/0x170
08297800:  [<080628d9>] timer_handler+0x49/0x60
08297820:  [<080759ca>] sig_handler_common_skas+0xaa/0x100
08297850:  [<08071b93>] alarm_handler+0x23/0x50
08297870:  [<ffffe420>] _etext+0xf7db7406/0x0
08297b80:  [<08060e2a>] default_idle+0x6a/0x80
08297bb0:  [<08064744>] init_idle_skas+0x24/0x30
08297bc0:  [<08060e4a>] cpu_idle+0xa/0x10
08297bd0:  [<0805e22f>] rest_init+0x1f/0x30
08297be0:  [<080495d6>] start_kernel+0x176/0x1b0
08297bf0:  [<0806477b>] start_kernel_proc+0x2b/0x30
08297c00:  [<08070b8a>] run_kernel_thread+0x3a/0x50
08297cd0:  [<0806448f>] new_thread_handler+0xaf/0x110
08297d20:  [<ffffe420>] _etext+0xf7db7406/0x0


Does anyone recognize this bug? I've been planning on upgrading, but would
like to know if the effort is likely to fix the issue. Unfortunately, this
is a production machine that's owned by another individual. So I need to be
careful about changes to the OS and kernel.

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
