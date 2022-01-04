Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4oGF-00CSBL-W5
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 18:10:17 +0000
Message-ID: <be290dc3-db9c-2940-91bb-c91bf42fd8f6@collabora.com>
Date: Tue, 4 Jan 2022 15:10:06 -0300
MIME-Version: 1.0
From: Walter Lozano <walter.lozano@collabora.com>
Subject: Occasional hung with UM after enable VMAP_STACK
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sjoerd Simons <sjoerd.simons@collabora.com>, ritesh sarraf <ritesh.sarraf@collabora.com>

Hi all,

I noticed that after "um: enable VMAP_STACK" [1] I experienced some 
occasional hung in my Gitlab CI jobs that use user-mode-linux to build 
distro images. The configuration use for the building is the one 
available from Debian, see [2] and [3]. Unfortunately I don't have much 
information, when the issue arises the job seems to hang and it is 
cancelled by Gitlab due to a job timeout.

So far I did some bisect to get the commit which introduces the issue 
and a quick check with latest Linux stable branch master to confirm the 
issue is still present. I know this is not a proper bug report but I 
thought it will be better to at least raise a comment.

Thanks in advance,

Walter

[1] http://lists.infradead.org/pipermail/linux-um/2021-August/001657.html

[2] https://packages.debian.org/bookworm/user-mode-linux

[3] https://salsa.debian.org/uml-team/user-mode-linux

-- 
Walter Lozano
Collabora Ltd.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

