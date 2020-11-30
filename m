Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjgGR-0004Lu-Q8
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 10:18:36 +0000
Message-ID: <366f7093a7e358a0d91232dfb744ba6902b5401b.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/5] um: simplify os_idle_sleep() and sleep longer
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 30 Nov 2020 11:18:16 +0100
In-Reply-To: <64ef8f80-be65-ebfb-dbe9-b0e6e32ed077@kot-begemot.co.uk>
References: <20201123200356.297213-1-johannes@sipsolutions.net>
 <20201123210307.9036fe7d71fa.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
 <64ef8f80-be65-ebfb-dbe9-b0e6e32ed077@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Mon, 2020-11-30 at 10:17 +0000, Anton Ivanov wrote:
> 
> > -void time_travel_sleep(unsigned long long duration);
> > +void time_travel_sleep(void);
> 
> This is missing the change in the definition when timetravel mode is not enabled.
> 
> As a result if TT is not enabled in the config the build fails.

Oops, sorry. I'll send fixed version.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

