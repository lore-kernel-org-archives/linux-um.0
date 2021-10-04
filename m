Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXUNH-007xB4-2a
 for linux-um@lists.infradead.org; Mon, 04 Oct 2021 20:15:48 +0000
Message-ID: <c77621b6131984b61132b426159d393964fb1b06.camel@sipsolutions.net>
Subject: Re: Bug 214611 - UM: stdout output ceases under certain conditions
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 04 Oct 2021 22:15:43 +0200
In-Reply-To: <a577f3ff-da05-a8e7-2740-4489c991ecf5@kot-begemot.co.uk>
References: <20211002210023.55861502@crass-HP-ZBook-15-G2>
 <aad9145655670d2f7d06a8dffd93d99171183fe0.camel@sipsolutions.net>
 <20211004115410.4716345d@crass-HP-ZBook-15-G2>
 <45651f920ed904702166da57aea5da7af0c1c0a0.camel@sipsolutions.net>
 <a577f3ff-da05-a8e7-2740-4489c991ecf5@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, development@efficientek.com
Cc: linux-um@lists.infradead.org

On Mon, 2021-10-04 at 21:14 +0100, Anton Ivanov wrote:
> > So I think we need Richard or somebody to chime in here - I can't really
> > disagree that the behaviour is strange, but clearly it seems intended,
> > for whatever reason.
> > 
> 
> I will have a look at it tomorrow. I remember fixing a similar bug 
> around 5.4-ish which was in the tree since the time of the dinosaurs.
> 
> I assume Glenn is running master, right? If not, what version.

He was running on 5.14.8, but I did all my experiments now with this on
5.15-rc, so master should be fine.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

