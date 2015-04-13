//
//  Context.h
//  Arazi Ol 2
//
//  Created by Arda Cicek on 29/12/13.
//  Copyright (c) 2013 Arda Cicek. All rights reserved.
//
#import "AC.h"
#import "ACContext.h"
#import "WorkerList.h"
#import "Worker.h"
#import "DaySummary.h"
#import "WorkList.h"

@interface Context : ACContext

+(Context *) sharedContext;


#pragma mark - Works

- (WorkList *) getWorks;
- (BOOL) writeWorks:(WorkList *) list;
- (BOOL) addWork:(Work *) work;
- (BOOL) removeWork:(Work *) work;

#pragma mark - Workers
- (WorkerList *) getWorkers;
- (BOOL) writeWorkers:(WorkerList *) list;
- (BOOL) addWorker:(Worker *) worker;
- (BOOL)updateWorkers:(WorkerList *)list;
- (BOOL) removeWorker:(Worker *) worker;

#pragma mark - DaySummary
- (BOOL) writeDaySummary:(DaySummary *) summary;
- (DaySummary *)getDaySummaryWith:(NSString *)dateString;

#pragma mark - Util
- (NSString *)dateStringFrom:(NSDate *)date;
- (NSString *) createFileName;
- (NSString *) getDocumentsPath;
- (NSString *) readFileAtPath:(NSString *)path;
- (BOOL) writeString:(NSString *) content toFileAtPath:(NSString *) path;
#pragma mark -
- (WorkerList *) getListAtPath:(NSString *) path;

- (BOOL) writeList:(WorkerList *) list toPath:(NSString *) path;


- (BOOL) addWorker:(Worker *) worker toListAtPath:(NSString *) path;
- (Worker *) getCallerWithID:(NSString *) workerID fromArray:(NSArray *) list;

- (BOOL) removeWorker:(Worker *) worker fromListAtPath:(NSString *) path;

#pragma mark - Dump Context

@property (nonatomic, strong) Worker *selectedWorker;
@property (nonatomic, strong) Work *selectedWork;
@property (nonatomic, strong) DailyWork *selecetedDailyWork;



@end
