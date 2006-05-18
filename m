Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fgklf-0004kq-9c for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 May 2006 08:50:27 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fgklf-0003D0-Dr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 May 2006 08:50:27 -0700
Received: from wx-out-0102.google.com ([66.249.82.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fgklc-000568-DC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 May 2006 08:50:27 -0700
Received: by wx-out-0102.google.com with SMTP id s10so32605wxc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 May 2006 08:50:23 -0700 (PDT)
Message-ID: <5d8380130605180850i443dd0b7wf603fbe364ec1345@mail.gmail.com>
From: "Nikola Knezevic" <laladelausanne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Disposition: inline
Subject: [uml-devel] debug uml
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
Date: Thu, 18 May 2006 17:50:22 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,
any solutions how to debug uml while it is booting?
I can trace it to process.c:start_userspace and a call to clone. After
that, I can't do anything, until I send HUP from another console,
which is a bit slow.

Any suggestions?

Thanks.
Nikola


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
