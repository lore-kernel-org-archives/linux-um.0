Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ihym1-0006W1-1T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 19:36:41 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ihym0-0003s6-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 19:36:40 -0700
Received: by wa-out-1112.google.com with SMTP id k22so2828937waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 16 Oct 2007 19:36:39 -0700 (PDT)
Message-ID: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
Date: Tue, 16 Oct 2007 22:36:39 -0400
From: Hrishikesh <hrishikesh.amur@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Dramatic drop in C3 state residency with NO_HZ patches
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0611593145=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@linux.intel.com

--===============0611593145==
Content-Type: multipart/alternative; 
	boundary="----=_Part_41495_10996723.1192588599636"

------=_Part_41495_10996723.1192588599636
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When running powertop, I notice that there is a dramatic drop in C3 state
residency when running the patched kernel. This happens when you run a
patched kernel but without the NO_HZ and HR timers options disabled. C3
state residency drops from about 90% to 50% when the UML kernel is idle.
This does not happen when the tickless option _is_ enabled.
Regards,
Hrishikesh Amur

------=_Part_41495_10996723.1192588599636
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When running powertop, I notice that there is a dramatic drop in C3 state residency when running the patched kernel. This happens when you run a patched kernel but without the NO_HZ and HR timers options disabled. C3 state residency drops from about 90% to 50% when the UML kernel is idle. This does not happen when the tickless option _is_ enabled. 
<br>Regards,<br>Hrishikesh Amur<br>

------=_Part_41495_10996723.1192588599636--


--===============0611593145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0611593145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0611593145==--

