Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1UwJja-0004VT-2C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 22:16:38 +0000
Received: from mail-ob0-f180.google.com ([209.85.214.180])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UwJjY-0003Ff-Db
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jul 2013 22:16:38 +0000
Received: by mail-ob0-f180.google.com with SMTP id eh20so6169382obb.11
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 08 Jul 2013 15:16:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51DB20CB.9020706@nod.at>
References: <51DB1EE5.5040108@google.com> <51DB20CB.9020706@nod.at>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Mon, 8 Jul 2013 18:16:06 -0400
Message-ID: <CADNZ+wTyryruLzaTDzw=502iLJwQ-wA_Rr5P_KJemRCFqXZxMg@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCHv3] uml: Fix which_tmpdir failure when
 /dev/shm is a symlink, and in other edge cases
To: Richard Weinberger <richard@nod.at>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On 8 July 2013 16:27, Richard Weinberger <richard@nod.at> wrote:
> Is this just a resend or did your alter the patch you sent me already?
> I'm about to send my UML patches to Linus tomorrow.

Just a re-send. I thought I was supposed to re-send linux-next patches
after the merge window opens. Sorry if that wasn't right--I'm new at
this. :)

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

