Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FPDWR-0006u3-9u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 22:54:15 -0800
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FPDWQ-0005Bj-BR
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Mar 2006 22:54:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 06B643C4C8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Mar 2006 22:54:13 -0800 (PST)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06011-02 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Mar 2006 22:54:12 -0800 (PST)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id E51BA3C48E
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Mar 2006 22:54:11 -0800 (PST)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Re: SMP skas requirements
Message-ID: <LEEIJGBJEEABAGOFFGAHAEGJDFAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200603302330.00256.blaisorblade@yahoo.it>
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
Date: Thu, 30 Mar 2006 22:54:08 -0800
To: user-mode-linux-devel@lists.sourceforge.net

> On Thursday 30 March 2006 13:30, Blaisorblade wrote:
> Sorry, forgot to finish. That patch keeps checking TMP,TMPDIR and
> TEMP (don't
> remember the order), but if none is set, it switches the default
> from /tmp
> to /dev/shm.

This makes sense. It does appear that the patch first checks the
environmental variable before using the defaults. While I would like to take
advantage of the neat feature Jeff is working on (hot plug memory), I have a
greater need for consistent and reliable speed.

Thanks!

Tony



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
