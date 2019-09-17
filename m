Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA9Zb-0004UD-20
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 09:15:00 +0000
Message-ID: <bfbb45a544415446e38fb89c08bb234047affa2b.camel@sipsolutions.net>
Subject: Re: [RFC v2 2/2] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 11:14:56 +0200
In-Reply-To: <1dd9e658-a6cd-39dd-09c7-d68ebcd7078c@cambridgegreys.com>
References: <1568671815-I895f9019593bd579566f14e5af9346e3c9b56f28@changeid>
 <1568671815-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
 <7583ac26d787ddf211473166136836f3472bf31e.camel@sipsolutions.net>
 <1dd9e658-a6cd-39dd-09c7-d68ebcd7078c@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Tue, 2019-09-17 at 10:09 +0100, Anton Ivanov wrote:

> I hope you do not mind - will repeat my ask. Can we have a series off 
> let's say current 5.x with all patches ready for test/review.

Well, Richard applied almost everything. We also spoke about the "Fix
LAST_IRQ usage" patch yesterday and he said he'd apply the one hunk of
it that you didn't already fix.

> Some of your patches have 3-4 versions with a fixed version coming 
> nearly immediately thereafter and for some of them I am a bit lost which 
> versions should I test/review at present.

The only open patches now are on

https://patchwork.ozlabs.org/project/linux-um/list/

and I've just updated the state of my stuff there.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

