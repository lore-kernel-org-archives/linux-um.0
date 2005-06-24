Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dltie-0000w4-T7	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 12:20:04 -0700
Received: from agminet04.oracle.com ([141.146.126.231])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1Dltib-0002Xp-O9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 12:20:04 -0700
Received: from agminet04.oracle.com (localhost [127.0.0.1])
	j5OJJtY0019121	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 14:19:55 -0500
Received: from rgmsgw300.us.oracle.com (rgmsgw300.us.oracle.com
	[138.1.186.49])j5OJJs0P019092
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 14:19:54 -0500
Received: from rgmsgw300.us.oracle.com (localhost [127.0.0.1])
	j5OJJsPv011453	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 13:19:54 -0600
Received: from [138.2.230.92] (agraves-lnx.us.oracle.com [138.2.230.92])
	j5OJJrb0011446
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Jun 2005 13:19:53 -0600
Message-ID: <42BC5CD9.2080005@oracle.com>
From: Allan Graves <allan.graves@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060807010904080105080303"
Subject: [uml-devel] os_lock_file removal
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
Date: Fri, 24 Jun 2005 15:19:53 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060807010904080105080303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys.  I'm working on developing a cluster file system and I'd like 
to simulate concurrent shared storage access using uml and disk files.  
I traced down the file locking, and it seems that (assuming I have a 
cluster file system that keeps things up to date in the metadata of the 
filesystem) if I remove this function I should be able to have more than 
1 instance accessing storage at the same time.  I realize this is a bit 
dangerous, since it involves *all* block devices,  but I don't see a 
much better way.  COW is not what I'm looking for, and that seems to be 
the standard answer.  Can anyone provide positive or negative feedback 
on this approach?  Possibly a better approach? 
Thanks,
Allan Graves

--------------060807010904080105080303
Content-Type: text/x-vcard; charset=utf8;
 name="allan.graves.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="allan.graves.vcf"

begin:vcard
fn:Allan Graves
n:Graves;Allan
email;internet:allan.graves@oracle.com
tel;work:603-8973276
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060807010904080105080303--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
