Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1Vgz3P-0007kU-Ue
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Nov 2013 15:41:59 +0000
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vgz3P-0000BQ-1G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Nov 2013 15:41:59 +0000
Received: by mail-qe0-f54.google.com with SMTP id 1so1350795qec.41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 14 Nov 2013 07:41:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4f471bf7dfaf984b17121486aeeb8233@nixia.no>
References: <52811BDA.2090705@google.com>
	<4f471bf7dfaf984b17121486aeeb8233@nixia.no>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Thu, 14 Nov 2013 10:41:33 -0500
Message-ID: <CADNZ+wSaFNOLbuyLuR0XX5-KagRBR2quJibHA9ncz1jikdV88A@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] uml: Simplify tempdir logic.
To: stian@nixia.no
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On 14 November 2013 08:25,  <stian@nixia.no> wrote:
> You should probably add /run/shm to the list of tmpfs directories to
> test for (ubuntu systems atleast use this).

On such systems /dev/shm is typically a symlink to /run/shm, so that's covered.

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

