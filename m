Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD269-0001hw-Lm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:39:57 -0700
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CD268-0006Op-JB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 07:39:57 -0700
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com
	[205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	3249C1800578 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 30 Sep 2004 14:39:51 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
MIME-Version: 1.0
From: "Martin Weber" <martin.weber@linuxmail.org>
Message-Id: <20040930143911.6098723EE7D@ws5-4.us4.outblaze.com>
Subject: [uml-devel] uml_mconsole and uml_kernel crashes by proc meminfo
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
Date: Thu, 30 Sep 2004 22:39:11 +0800
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Hi,  
  
When I use the uml_mconsole and call "proc meminfo", around the 
5th time, both uml_mconsole and uml_kernel crashes.  
This happens with kernel 2.6.7 and uml-patch-2 and also with kernel 
2.6.8.1 and uml-patch-2.6.8.1-1.  
There seems to be no problem with kernel 2.4.23.  
Also "cat /proc/meminfo" from inside the uml-instance works 
correct.  
  
Does anybody know how to fix this proplem?  
Is there a patch or a workaround? 
  
Thanks,  
  
Martin 
 
 
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
