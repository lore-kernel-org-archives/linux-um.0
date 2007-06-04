Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvMKE-0007DA-R0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 16:51:03 -0700
Received: from wa-out-1112.google.com ([209.85.146.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvMKC-0007Ff-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 16:51:02 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1964289waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 04 Jun 2007 16:50:59 -0700 (PDT)
Message-ID: <3aab51dc0706041650r16c90d80s5b9dafc4caaacbf@mail.gmail.com>
Date: Mon, 4 Jun 2007 16:50:59 -0700
From: "Haifeng He" <hehaifeng@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Error: F_SETLK failed, file already locked by pid 0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2145394809=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============2145394809==
Content-Type: multipart/alternative; 
	boundary="----=_Part_12348_23110100.1181001059162"

------=_Part_12348_23110100.1181001059162
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all

I was making some changes to UML kernel and my changes would cause the UML
to
fail to run sometimes. My problem is, if my modified UML kernel fails, it
causes the
filesystem loaded locked and can't be loaded again by other UML kernel. The
error
message shows,"* *F_SETLK failed, file already locked by pid 0".

I know there is already a description in the UML website but either the
solutions seem
to be helpful in my case. I have killed all the processes related to UML but
the file
is still locked. I can only either reboot the machine or make another copy
of that file.
Is there other simple way to solve the problem?

Thanks

Haifeng
**

------=_Part_12348_23110100.1181001059162
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi, all</div>
<div>&nbsp;</div>
<div>I was making some changes to UML kernel and my changes would cause the UML to</div>
<div>fail to run sometimes. My problem is, if my modified UML kernel fails, it causes the </div>
<div>filesystem loaded locked and can&#39;t be loaded again by other UML kernel. The error</div>
<div>message shows,&quot;<strong> </strong>F_SETLK failed, file already locked by pid 0&quot;.</div>
<div>&nbsp;</div>
<div>I know there is already a description in the UML website but either the solutions seem</div>
<div>to be helpful in my case. I have killed all the processes related to UML but the file</div>
<div>is still locked. I can only either reboot the machine or make another copy of that file.</div>
<div>Is there other simple way to solve the problem?</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>Haifeng</div>
<div><strong></strong>&nbsp;</div>

------=_Part_12348_23110100.1181001059162--


--===============2145394809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2145394809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2145394809==--

