Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CplRS-0001UI-2Q for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 02:46:02 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CplRQ-00054i-Ap for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Jan 2005 02:46:01 -0800
Message-ID: <3809.83.109.31.19.1105785957.squirrel@83.109.31.19>
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] uml_moo
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
Date: Sat, 15 Jan 2005 11:45:57 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

I have one issue with uml_moo.

uml_moo and the kernel cow drivers doesn't seem to use the same method
when calculating the size of the backing file.

I used /dev/hdc1 which was an block device (147 GB partition)

uml kernel perfectely finds the correct size. uml_moo uses stat on the
device which gives size 0, og uml_moo fails. Also I see that it is
compiled with 64bit file support, but shouldn't you define _GNU_SOURCE as
well? Since off_t didn't need %lld in the printf, but %ld as the
source-code now uses which is 32bit on i386 atleast. The last thingy was
just a question.


Stian


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
