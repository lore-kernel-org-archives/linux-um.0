Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cv26m-0000xU-VJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Jan 2005 15:34:28 -0800
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cv26l-0003Hk-BU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Jan 2005 15:34:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 1FD832881A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Jan 2005 15:34:26 -0800 (PST)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01471-06 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Jan 2005 15:34:21 -0800 (PST)
Received: from sterling (c-67-160-159-191.client.comcast.net [67.160.159.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id C2B5528818
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Jan 2005 15:34:20 -0800 (PST)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] 2.6.11-rc1 ...
Message-ID: <CBELIFGMBIEPIEOFCJFAMEDHCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200501211407.09896.blaisorblade@yahoo.it>
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
Date: Sat, 29 Jan 2005 15:34:56 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Friday 21 January 2005 13:15, Gerd Knorr wrote:
>>   Hi,
>>
>> Anyone looked at 2.6.11-rc1 for the host?  Some more ptrace cleanups
>> happened there, and one of the changes conflicts with the sysemu code in
>> the skas-v7 patch for 2.6.10.  To me it's not clear how to solve that
>> conflict as I'm not familier with the sysemu stuff and how these tree
>> trace flags (syscall, sysemu, singlestep) play together ...
>
>> The conflicting changeset is attached below for reference.  There are
>> also some more ptrace changes (for singlestep) which might need fixups
>> in sysemu.
>
>>   Gerd
>
> I've already solved those conflict earlier on -rc1 (not tested) but I
didn't
> polish it out yet... if you are in a hurry, I can finish it and post the
> result today on the ML. If not, I'll publish it later.

Blaisor,

Have you published your solution to the skas-v7 conflicts with the
2.6.11-rc1 kernel? Even better, I would like to try the 2.6.11-rc2 or
2.6.11-rc2-bk7 kernels as a skas-enabled host. Thanks!

Tony



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
