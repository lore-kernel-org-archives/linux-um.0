Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXis4-0001wo-9d	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 09:55:12 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DXirN-0004jP-45	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 09:55:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <41127.157.182.194.12.1116263064.squirrel@157.182.194.161>
In-Reply-To: <41127.157.182.194.12.1116263064.squirrel@157.182.194.161>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505161853.42019.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] uml patch
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
Date: Mon, 16 May 2005 18:53:41 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Ashwin Kumar Tanugula <atanugul@csee.wvu.edu>, user-mode-linux-devel@lists.sourceforge.net

On Monday 16 May 2005 19:04, Ashwin Kumar Tanugula wrote:
> hi!
> I have a question regarding applying a uml patch. Can i apply a uml
> 2.6.0-test9 patch to a linux 2.6.8.1-4 kernel?
No, I can bet it won't compile without testing. Why don't you use the 2.6.8.1 
patch, or even a later kernel?

Also, the "-4" part makes me think it's not a vanilla kernel, which calls for 
more problem.
> should the uml patch 
> version and kernel version be the same always??
No, especially on 2.4 kernels they can be different; however, the more 
different are the two versions, the more you'll likely get into trouble. 
Especially for 2.6 kernels.

Also, with 2.6 you'll likely want to use the latest available UML version for 
greater stability. We currently keep fixing more bugs than we introduce.
> Thanks,
> Ashwin

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
