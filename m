Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPwiy-0003AN-2V for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 22:01:08 -0700
Received: from [203.196.196.68] (helo=BLR-MAIL.NETD.COM)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BPwiw-0007bT-N0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 22:01:07 -0700
Received: from netd.com ([10.91.0.14])
	by BLR-MAIL.NETD.COM (8.12.10/8.12.8) with ESMTP id i4I50g3t005079
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 10:30:48 +0530
Message-ID: <40A9970F.9060201@netd.com>
From: pronoy debnath <pdebnath@netd.com>
MIME-Version: 1.0
References: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
Content-Type: multipart/alternative;
	boundary="------------050204050200030005040301"
Subject: [uml-devel] how to do programming in UML
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
Date: Tue, 18 May 2004 10:24:39 +0530
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------050204050200030005040301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,
    The root_fs, I am using for uml, does not contain gcc.
   
     Is it possible to compile a program using host machine's gcc and 
libraries?
     If yes, how can I do it?

Thanks,
Pronoy


Henrik Nordstrom wrote:

>On Mon, 17 May 2004, Joe Marzot wrote:
>
>  
>
>>A little more data on this one - the behaviour I see with these mounts 
>>is that
>>
>>mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob
>>
>>succeeds but mounts the hosts / dir instead of the desired view extended 
>>pathname of the ClearCase vob.
>>    
>>
>
>This is a known bug in 2.4.24-2. A patch can be found in the archives or 
>from http://marasystems.com/download/uml/
>
>If you need hostfs then you should probably stick to 2.4.24-1 for the time
>being. Jeff is doing some heavy restructuring of the uml host file access
>methods while adding the humfs and as a result of this the hostfs support
>has become very unstable while the combined supporting framework for humfs
>and hostfs is taking shape. Hopefully this will soon result in a much 
>better hostfs than before, but at the moment things is a bit shaky..
>
>Regards
>Henrik
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: SourceForge.net Broadband
>Sign-up now for SourceForge Broadband and get the fastest
>6.0/768 connection for only $19.95/mo for the first 3 months!
>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>  
>

--------------050204050200030005040301
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
Hi,<br>
&nbsp;&nbsp;&nbsp; The root_fs, I am using for uml, does not contain gcc.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp; Is it possible to compile a program using host machine's gcc and
libraries?<br>
&nbsp;&nbsp;&nbsp;&nbsp; If yes, how can I do it?<br>
<br>
Thanks,<br>
Pronoy<br>
<br>
<br>
Henrik Nordstrom wrote:<br>
<blockquote type="cite"
 cite="midPine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com">
  <pre wrap="">On Mon, 17 May 2004, Joe Marzot wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">A little more data on this one - the behaviour I see with these mounts 
is that

mount -t hostfs none /mnt/mybob -o /view/myview/vob/myvob

succeeds but mounts the hosts / dir instead of the desired view extended 
pathname of the ClearCase vob.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is a known bug in 2.4.24-2. A patch can be found in the archives or 
from <a class="moz-txt-link-freetext" href="http://marasystems.com/download/uml/">http://marasystems.com/download/uml/</a>

If you need hostfs then you should probably stick to 2.4.24-1 for the time
being. Jeff is doing some heavy restructuring of the uml host file access
methods while adding the humfs and as a result of this the hostfs support
has become very unstable while the combined supporting framework for humfs
and hostfs is taking shape. Hopefully this will soon result in a much 
better hostfs than before, but at the moment things is a bit shaky..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
<a class="moz-txt-link-freetext" href="http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click">http://ads.osdn.com/?ad_id=2562&amp;alloc_id=6184&amp;op=click</a>
_______________________________________________
User-mode-linux-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel</a>
  </pre>
</blockquote>
</body>
</html>

--------------050204050200030005040301--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
